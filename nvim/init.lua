_G.Lib = require("lib")

require("config.options")
require("config.lazy")

if Lib.plugins.has("snacks.nvim") then
  _G.Snacks = require("snacks")
end

Lib.root.setup()

require("config.keymaps")
require("config.abbrevs")
require("config.autocmds")

vim.cmd.colorscheme("nightfox")
