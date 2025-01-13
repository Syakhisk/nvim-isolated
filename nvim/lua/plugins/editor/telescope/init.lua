local util = require "plugins.editor.telescope.util"
local actions = require "telescope.actions"

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<c-p>", util.find_files(), desc = "Find Files (root dir)" },
    },
    opts = {
      defaults = {
        winblend = 0,
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          horizontal = { size = { width = "100%", height = "60%" }},
          vertical = { size = { width = "100%", height = "90%" }},
        },
        create_layout = require("plugins.editor.telescope.layout").create_layout,
      },
      pickers = {
        colorscheme = { enable_preview = true },
        git_files = { prompt_title = "Find Files (Git)" },
        find_files = { prompt_title = "Find Files" },
        buffers = {
          prompt_title = "Buffers",
          mappings = {
            i = { ["<c-l>"] = actions.delete_buffer },
            n = { ["<c-l>"] = actions.delete_buffer },
          },
        },
      },
    },
  },
}
