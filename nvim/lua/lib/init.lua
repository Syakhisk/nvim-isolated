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

M.interval = function(fn, ms)
  local uv = vim.uv or vim.loop
  local t = uv.new_timer()

  t:start(
    0,
    ms,
    vim.schedule_wrap(function()
      if t:is_closing() then
        return
      end
      fn()
    end)
  )

  return function()
    if not t:is_closing() then
      t:stop()
      t:close()
    end
  end
end

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

return M
