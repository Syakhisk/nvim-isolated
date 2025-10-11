---@type LazySpec
return {
  "folke/snacks.nvim",
  version = "v2.*",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    indent = { enabled = true },
    notifier = { enabled = true },
  },
}
