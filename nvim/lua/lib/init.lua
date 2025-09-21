---@class Lib
---@field log LibLog
---@field modules LibModules
---@field strings LibStrings
---@field loader LibLoader
---@field formatter LibFormatter
---@field globals LibGlobals
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
