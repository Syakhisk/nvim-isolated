local M = {}

function M.debounce(ms, fn)
  local timer = vim.uv.new_timer()

  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

M.lint = function()
  local lint = require("lint")

  local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")

  -- Use nvim-lint's logic first:
  -- * checks if linters exist for the full filetype first
  -- * otherwise will split filetype by "." and add all those linters
  -- * this differs from conform.nvim which only uses the first filetype that has a formatter
  local names = lint._resolve_linter_by_ft(vim.bo.filetype)

  -- Create a copy of the names table to avoid modifying the original.
  names = vim.list_extend({}, names)

  -- Add fallback linters.
  if #names == 0 then
    vim.list_extend(names, lint.linters_by_ft["_"] or {})
  end

  -- Add global linters.
  vim.list_extend(names, lint.linters_by_ft["*"] or {})

  -- Filter out linters that don't exist or don't match the condition.
  local ctx = { filename = vim.api.nvim_buf_get_name(0) }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
  names = vim.tbl_filter(function(name)
    local linter = lint.linters[name]
    if not linter then
      vim.notify("Linter not found: " .. name, vim.log.levels.WARN)
    end

    return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
  end, names)

  if #names < 1 then
    return
  end

  -- Run linters.
  local has_fidget, progress = pcall(require, "fidget.progress")
  local handle

  if has_fidget then
    handle = progress.handle.create({
      title = "lint",
      message = "Linting...",
      lsp_client = { name = "nvim-lint" },
    })
  end

  lint.try_lint(names)

  local clean

  clean = M.interval(function()
    local running = lint.get_running(0)

    if #running < 1 then
      handle:report({ message = "Done" })
      handle:finish()
      clean()

      return
    end
  end, 100)
end

function M.lint_with_progress()
  local lint = require("lint")

  -- Get current buffer name for notifications
  local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  if bufname == "" then
    bufname = "[No Name]"
  end

  -- Start with cspell
  lint.try_lint("cspell")

  -- Use nvim-lint's logic first:
  -- * checks if linters exist for the full filetype first
  -- * otherwise will split filetype by "." and add all those linters
  -- * this differs from conform.nvim which only uses the first filetype that has a formatter
  local names = lint._resolve_linter_by_ft(vim.bo.filetype)

  -- Create a copy of the names table to avoid modifying the original.
  names = vim.list_extend({}, names)

  -- Add fallback linters.
  if #names == 0 then
    vim.list_extend(names, lint.linters_by_ft["_"] or {})
  end

  -- Add global linters.
  vim.list_extend(names, lint.linters_by_ft["*"] or {})

  -- Filter out linters that don't exist or don't match the condition.
  local ctx = { filename = vim.api.nvim_buf_get_name(0) }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
  names = vim.tbl_filter(function(name)
    local linter = lint.linters[name]
    if not linter then
      Lib.log.to_file("Linter not found: " .. name)
    end

    return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
  end, names)

  -- Run linters with notifications
  if #names > 0 then
    -- Combine cspell with other linters for display
    local all_linters = vim.list_extend({ "cspell" }, names)
    local linter_list = table.concat(all_linters, ", ")

    -- Try to use Fidget if available, otherwise fall back to vim.notify
    local has_fidget, fidget = pcall(require, "fidget")
    local progress_handle

    if has_fidget then
      -- Use Fidget for progress notifications
      progress_handle = fidget.progress.handle.create({
        title = "nvim-lint",
        message = string.format("Linting %s", bufname),
        lsp_client = { name = "nvim-lint" },
      })
    else
      -- Fallback to vim.notify
      local start_msg = string.format("Linting %s with %s", bufname, linter_list)
      vim.notify(start_msg, vim.log.levels.INFO, {
        title = "nvim-lint",
        icon = "🔍",
      })
    end

    -- Run the actual linting
    lint.try_lint(names)

    -- Show completion notification after a brief delay
    vim.defer_fn(function()
      if progress_handle then
        -- Complete Fidget progress
        progress_handle:finish()
      else
        -- Fallback completion notification
        local end_msg = string.format("Linting completed for %s", bufname)
        vim.notify(end_msg, vim.log.levels.INFO, {
          title = "nvim-lint",
          icon = "✅",
        })
      end
    end, 500)
  end
end

M.interval = function(fn, ms)
  local uv = vim.uv or vim.loop
  local t = uv.new_timer()

  t:start(
    0,
    ms,
    vim.schedule_wrap(function()
      if t:is_closing() then
        return
      end
      fn()
    end)
  )

  return function()
    if not t:is_closing() then
      t:stop()
      t:close()
    end
  end
end

return M
