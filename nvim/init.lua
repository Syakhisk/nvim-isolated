_G.Lib = require("lib")
_G.H = require("lib.helpers")

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.abbrevs")
require("config.autocmds")

vim.cmd.colorscheme("nightfox")
