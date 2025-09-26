_G.Lib = require("lib")

require("config.options")
require("config.lazy")
if Lib.plugins.has("snacks") then
  _G.Snacks = require("snacks")
end

require("config.keymaps")
require("config.abbrevs")
require("config.autocmds")

vim.cmd.colorscheme("nightfox")
