local util = require("plugins.editor.telescope.util")
local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")

---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    -- version = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      require("plugins.editor.telescope.deps.telescope_undo"),
      require("plugins.editor.telescope.deps.telescope_live_greps_args"),
    },
    opts = {
      defaults = {
        winblend = 0,
        sorting_strategy = "ascending",
        -- layout_strategy = "flex",
        -- create_layout = require("plugins.editor.telescope.layout").create_layout,
        layout_strategy = "bottom_pane",
        layout_config = {
          horizontal = { size = { width = "100%", height = "60%" } },
          vertical = { size = { width = "100%", height = "90%" } },
          bottom_pane = { height = 0.625 },
        },
        mappings = {
          n = {
            ["<tab>"] = actions.move_selection_next,
            ["<s-tab>"] = actions.move_selection_previous,

            ["<c-s-p>"] = layout.toggle_preview,
            ["<M-p>"] = layout.toggle_preview,

            ["<c-n>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<c-p>"] = actions.move_selection_better + actions.toggle_selection,
            ["<c-space>"] = actions.toggle_selection,
          },
          i = {
            ["<tab>"] = actions.move_selection_next,
            ["<s-tab>"] = actions.move_selection_previous,

            ["<c-s-p>"] = layout.toggle_preview,
            ["<M-p>"] = layout.toggle_preview,

            ["<c-n>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<c-p>"] = actions.move_selection_better + actions.toggle_selection,
            ["<c-space>"] = actions.toggle_selection,

            -- ignore shortcuts for lsp pickers
            ["<c-h>"] = { " !mock !_test.go ", type = "command" },

            -- putting it on 'extensions' not working
            -- TODO: try to move it there, follow lazyvim way
            ["<C-s-h>"] = util.key_live_grep_actions,

            -- refine
            ["<c-f>"] = actions.to_fuzzy_refine,
          },
        },
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
