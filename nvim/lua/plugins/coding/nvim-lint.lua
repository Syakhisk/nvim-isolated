---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  opts = {
    -- Event to trigger linters
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
      docker = { "hadolint" },
    },
  },
  -- TODO: fix linting logic related to filetype checks and cspell
  config = function(_, opts)
    local M = {}

    local lint = require("lint")

    opts.linters = opts.linters or {}

    -- Change severity of cspell
    opts.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
      return diagnostic
    end)

    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        if type(linter.prepend_args) == "table" then
          lint.linters[name].args = lint.linters[name].args or {}
          vim.list_extend(lint.linters[name].args, linter.prepend_args)
        end
      else
        lint.linters[name] = linter
      end
    end
    lint.linters_by_ft = opts.linters_by_ft

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

    function M.lint()
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

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = M.debounce(100, M.lint),
    })
  end,
}
