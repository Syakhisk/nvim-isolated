local M = {}

M.key_esc = function()
  vim.cmd("noh")
  return "<esc>"
end

M.inspec_tree = function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end

------
------

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
---@param name string package name
---@param fn fun(pkg?: any) callback
M.with = function(name, fn)
  local ok, pkg = pcall(require, name)
  if not ok then
    Lib.log.to_file("[keymap] " .. name .. " is not installed")
    return
  end

  fn(pkg)
end

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

return M
