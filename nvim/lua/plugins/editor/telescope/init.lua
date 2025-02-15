local util = require("plugins.editor.telescope.util")
local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      require("plugins.editor.telescope.deps.telescope_undo"),
      require("plugins.editor.telescope.deps.telescope_live_greps_args"),
    },
    keys = {
      { "<c-p>", util.find_files(), desc = "Find Files (root dir)" },
      { "<leader>sB", require("telescope.builtin").builtin, desc = "Telescope Builtins" },
      { "<leader>sf", util.find_files(), desc = "Find Files (root dir)" },
      { "<leader>sj", require("telescope.builtin").jumplist, desc = "Telescope Jumps" },
      { "<leader>sv", require("telescope.builtin").git_status, desc = "Git Status" },
      { "<leader>sz", require("telescope.builtin").spell_suggest, desc = "Suggest Spelling" },

      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },

      -- find
      { "<leader>bs", require("telescope.builtin").buffers, desc = "Buffers" },
      {
        "<leader>fb",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
        desc = "Buffers",
      },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },

      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },

      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
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
