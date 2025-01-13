-- local specs = require("lib.require_all").require_all(2)
-- return specs

-- Udin0: /Users/syakhisk.syari/nvim-isolated/nvim/lua/plugins/coding/lazydev.lua
-- Udin1: /Users/syakhisk.syari/nvim-isolated/nvim
-- Nidu: /Users/syakhisk.syari/nvim-isolated/nvim/lua/plugins/coding/lazydev

-- local str1 = "/Users/syakhisk.syari/nvim-isolated/nvim/lua/plugins/coding/lazydev.lua"
-- local str2 = "/Users/syakhisk.syari/nvim-isolated/nvim"
-- local str3 = str1:gsub(str2, "")

local str1 = "udin-petot"
local str2 = "udin-"
local str3 = str1:gsub(str2, "")
vim.notify("Udin0: " .. str3)

return {}
