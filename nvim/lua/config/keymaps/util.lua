local M = {}

--- supercharged map
---@param lhs string Left-hand side |{lhs}| of the mapping.
---@param rhs string|function Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param keymap_opts? vim.keymap.set.Opts
---@param opts? {mode?: string|string[], with?: string}
M.map = function(lhs, rhs, keymap_opts, opts)
  opts = opts or {}

  local mode = opts.mode or "n"

  if opts.with then
    M.with(opts.with, function()
      vim.keymap.set(mode, lhs, rhs, keymap_opts)
    end)
    return
  end

  vim.keymap.set(mode, lhs, rhs, keymap_opts)
end

----------
-- Pane
----------
M.paneToggleSize = function()
  if vim.g._pane_maximized == true then
    vim.g._pane_maximized = false
    vim.cmd("wincmd =")
  else
    vim.g._pane_maximized = true
    vim.cmd("wincmd |")
  end
end

----------
-- Buffers
----------

M.bufferlineToggle = function()
  vim.opt.showtabline = vim.opt.showtabline:get() ~= 0 and 0 or 2
end

M.bufferFormat = function()
  local has_fidget, progress = pcall(require, "fidget.progress")
  local handle

  if has_fidget then
    handle = progress.handle.create({
      title = "format",
      message = "Formatting...",
      lsp_client = { name = "format" },
    })
  end

  local is_visual = vim.fn.mode():match("[vV]")

  local range
  if is_visual then
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")

    range = {}
    range.start = { line = start_pos[1] - 1, character = start_pos[2] }
    range["end"] = { line = end_pos[1] - 1, character = end_pos[2] }
  end

  local ok, conform = pcall(require, "conform")
  if not ok then
    vim.notify("conform not found, fallback to lsp buf format")
    vim.lsp.buf.format({ async = true, range = range })

    if is_visual then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
    end

    vim.defer_fn(function()
      handle:report({ message = "Done" })
      handle:finish()
    end, 500)
    return
  end

  conform.format({ async = true, lsp_fallback = true, force = true, range = range }, function(err, did_edit)
    if err then
      handle:report({ message = "❌ Failed" })
      handle:finish()
      return
    end

    handle:report({ message = "Done" })
    handle:finish()
  end)

  if is_visual then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  end
end

-- M.bufferFormat = function()
--   local ok, conform = pcall(require, "conform")
--
--   local start_pos = vim.api.nvim_buf_get_mark(0, "<")
--   local end_pos = vim.api.nvim_buf_get_mark(0, ">")
--   local range = {
--     start = { line = start_pos[1] - 1, character = start_pos[2] },
--     ["end"] = { line = end_pos[1] - 1, character = end_pos[2] },
--   }
--
--   if not ok then
--     vim.lsp.buf.format({ async = true, range = range })
--   else
--     conform.format({ async = true, lsp_fallback = true, force = true, range = range })
--   end
--
--   if vim.fn.mode():match("[vV]") then
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
--   end
-- end

-- M.format = function()
--   local ok, conform = pcall(require, "conform")
--
--   if not ok then
--     vim.lsp.buf.format()
--   end
--
--   conform.format()
-- end

M.splitsCloseAndBufferUnload = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local windows = vim.fn.getbufinfo(bufnr)[1].windows

  if #windows == 1 then
    vim.cmd("bd")
  else
    vim.cmd("close")
  end
end

M.bufferGetFiletype = function()
  local filetype = vim.bo.filetype
  vim.notify("Filetype of the current buffer is \n" .. filetype)
end

M.bufferSetFiletype = function()
  local filetype = vim.fn.input("Set filetype to: ", vim.bo.filetype, "filetype")
  vim.bo.filetype = filetype
end

----------
-- Project
----------
M.projectChangeToGitRoot = function()
  vim.api.nvim_set_current_dir(Lib.root.git())
end

M.projectCompareWithMaster = function()
  require("gitsigns").change_base("master", true)
  vim.cmd("Neotree git_status git_base=master position=right")
end

M.projectCompareWith = function()
  require("snacks").input({ prompt = "Select git branch or commit sha" }, function(input)
    if input ~= "" then
      vim.notify("Comparing with " .. input, vim.log.levels.INFO)

      require("gitsigns").change_base(input, true)
      vim.cmd(("Neotree git_status git_base=%s position=right"):format(input))
    end
  end)
end

-- m.projectCompareWithBranch = function()
--   require("gitsigns").change_base("master", true)
--   vim.cmd "Neotree git_status git_base=master position=right"
-- end

M.projectGrepWithContext = function()
  local lineContext = 1
  -- TODO: make language-agnostic
  local defaultCommand = string.format("grep -g '!*_test.go' -g '!mock' --context=%d ''", lineContext)
  local command = vim.fn.input("Search: ", defaultCommand)
  vim.cmd(command)
end

----------
-- Misc
----------

M.key_esc = function()
  local ok, snacks = pcall(require, "snacks")
  if ok then
    snacks.notifier.hide()
  end

  vim.cmd.nohlsearch()
  return "<esc>"
end

M.inspec_tree = function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end

M.loclist = function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

M.qflist = function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

M.diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

--- `with` will check if `name` is installed using pcall, passing in the required module
--- as the param of the second argument.
---@param name string|string[] package name
---@param fn fun(pkg?: any|any[]) callback
M.with = function(name, fn)
  local names = {}
  local pkgs = {}

  if type(name) == "string" then
    names = { name }
  else
    names = name
  end

  for _, n in ipairs(names) do
    local ok, pkg = pcall(require, n)
    if not ok then
      Lib.log.to_file("[keymap] " .. n .. " is not installed")
      return
    end

    table.insert(pkgs, pkg)
  end

  if #pkgs == 0 then
    return
  end

  if #pkgs == 1 then
    fn(pkgs[1])
    return
  end

  fn(unpack(pkgs))
end

return M
