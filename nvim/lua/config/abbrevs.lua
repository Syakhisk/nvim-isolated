-- Commandline abbreviations
local function command_mode_abbrevs()
  vim.cmd.cabbrev("Wq", "wq")
  vim.cmd.cabbrev("Wqa", "wqa")

  vim.cmd.cabbrev("W", "w")
  vim.cmd.cabbrev("Q", "q")
  vim.cmd.cabbrev("Qa", "qa")
  vim.cmd.cabbrev("Set", "set")
end

-- Insert mode abbreviations
local function insert_mode_abbrevs()
  local path = vim.fn.stdpath("config") .. "/abbreviations.json"

  local abbrs = {}

  -- Load abbrevs from file
  local status_ok = pcall(function()
    if vim.fn.filereadable(path) ~= 1 then
      vim.notify("Abbreviations file not found: " .. path, vim.log.levels.WARN)
      return
    end

    local json = vim.fn.readfile(path)
    abbrs = vim.fn.json_decode(table.concat(json, "\n"))
  end)

  if not status_ok then
    vim.notify("Failed to load abbreviations", vim.log.levels.ERROR)
    return
  end

  -- Assign abbrevs
  for word, typos in pairs(abbrs) do
    if type(typos) == "string" then
      typos = { typos }
    end

    for _, typo in ipairs(typos) do
      vim.cmd.iabbrev({ args = { typo, word } })
    end
  end
end

insert_mode_abbrevs()
command_mode_abbrevs()
