---@class Lib
---@field log LibLog
---@field plugins LibPlugins
---@field strings LibStrings
---@field constants LibConstants
local M = {}

setmetatable(M, {
  __index = function(t, k)
    local ok, mod = pcall(require, "lib." .. k)
    if not ok then
      return
    end

    t[k] = mod
    return t[k]
  end,
})

return M
