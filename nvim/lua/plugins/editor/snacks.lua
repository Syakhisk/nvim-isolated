---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {},
  keys = require("config.keymaps").plugin_snacks,
}
