---@class LibColor
local M = {}

local function get_hl(name, attr)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
  if not ok or not hl then
    return nil
  end
  return hl[attr] and string.format("#%06x", hl[attr]) or nil
end

M.fg = get_hl("Normal", "fg")
M.bg = get_hl("Normal", "bg")

return M
