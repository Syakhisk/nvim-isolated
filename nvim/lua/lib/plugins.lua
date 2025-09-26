---@class LibPlugins
local M = {}

function M.is_loaded(name)
  local Config = require("lazy.core.config")
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

---@param name string
function M.get(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param name string
---@param path string?
function M.get_path(name, path)
  local plugin = M.get(name)
  path = path and "/" .. path or ""
  return plugin and (plugin.dir .. path)
end

---@param plugin string
function M.has(plugin)
  return M.get(plugin) ~= nil
end

return M
