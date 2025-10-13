---@class Lib: LazyUtilCore
---@field log LibLog
---@field plugins LibPlugins
---@field strings LibStrings
---@field constants LibConstants
---@field lsp LibLSP
---@field treesitter LibTreesitter
---@field root LibRoot
local M = {}

setmetatable(M, {
  __index = function(t, k)
    local LazyUtil = require("lazy.core.util")

    if LazyUtil[k] then
      return LazyUtil[k]
    end

    local ok, mod = pcall(require, "lib." .. k)
    if not ok then
      return
    end

    t[k] = mod
    return t[k]
  end,
})

M.wrap = function(f, ...)
  local args = ...
  return function()
    f(args)
  end
end

return M
