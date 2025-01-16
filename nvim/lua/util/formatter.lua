---@class UtilFormatter
local M = {}

M.format = function()
  local ok, conform = pcall(require, "conform")

  if not ok then
    vim.lsp.buf.format()
  end

  conform.format()
end

return M
