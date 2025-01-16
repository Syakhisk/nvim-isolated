---@class Custom
---@field log UtilLog
---@field pkg UtilPkg
---@field strings UtilStrings
---@field loader UtilLoader
---@field formatter UtilFormatter
local M = {}

setmetatable(M, {
  __index = function(t, k)
    local ok, mod = pcall(require, "util." .. k)
    if not ok then
      return
    end

    t[k] = mod
    return t[k]
  end,
})

return M
