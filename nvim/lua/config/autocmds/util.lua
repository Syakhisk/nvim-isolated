local M = {}

--- util function to create augroup
--- @param name string String: The name of the group
--- @return integer # Integer id of the created group.
M.augroup = function(name)
  return vim.api.nvim_create_augroup("suntinx_" .. name, { clear = true })
end

--- @param event any (string|array) Event(s) that will trigger the handler (`callback` or `command`).
--- @param opts vim.api.keyset.create_autocmd
--- @return integer # Autocommand id (number)
M.autocmd = function(event, opts)
  return vim.api.nvim_create_autocmd(event, opts)
end

return M
