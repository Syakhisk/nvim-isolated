return {
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    version = "^1.0.0",
    config = function()
      require("util.pkg").on_load("telescope.nvim", function()
        require("telescope").load_extension "live_grep_args"
      end)
    end,
    keys = {
      {
        "<leader>sg",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
        desc = "Live Grep with rg Args",
      },
      {
        "<leader>sw",
        "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<cr>",
        desc = "Live Grep Args - Word under cursor",
      },
      {
        "<leader>sv",
        "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<cr>",
        desc = "Live Grep Args - Visual Selection",
        mode="v"
      },
    },
  },
}
