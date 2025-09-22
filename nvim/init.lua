_G.Lib = require("lib")
_G.Globals = require("lib.globals")

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.abbrevs")
require("config.autocmds")

vim.cmd.colorscheme("nightfox")
