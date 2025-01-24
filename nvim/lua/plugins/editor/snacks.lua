---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {},
  keys = function()
    local snacks = require("snacks")
    return {
      { "<leader>gg", snacks.lazygit.open, desc = "Lazygit Open" },
      { "<leader>gf", snacks.lazygit.log_file, desc = "Lazygit Current File History" },
      { "<leader>gl", snacks.lazygit.log, desc = "Lazygit Log Open" },
    }
  end,
}
