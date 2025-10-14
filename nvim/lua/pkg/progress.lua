---@class Progressbar
---@field title string
---@field handle? ProgressHandle
local progressbar = {}
progressbar.__index = progressbar

---@class ProgressbarClass
local ProgressbarClass = {}

---@param title string
---@return Progressbar
function ProgressbarClass.new(title)
  local self = setmetatable({}, progressbar)
  self.title = title

  local has_fidget, progress = pcall(require, "fidget.progress")
  if not has_fidget then
    vim.notify("Progressbar failed: snacks not installed", vim.log.levels.ERROR)
    return self
  end

  self.handle = progress.handle.create({
    title = self.title,
    lsp_client = { name = title },
  })
  return self
end

---@param msg string
function progressbar:update(msg)
  self.handle:report({ message = msg })
end

---@param msg? string defaults: Cancelled.
function progressbar:cancel(msg)
  msg = msg ~= nil and msg or "Cancelled."
  self.handle:report({ message = msg })
  -- self.handle:cancel()
  self.handle:finish()
end

---@param msg? string defaults: Done
function progressbar:finish(msg)
  msg = msg ~= nil and msg or "Done."
  self.handle:report({ message = msg })
  self.handle:finish()
end

return ProgressbarClass
