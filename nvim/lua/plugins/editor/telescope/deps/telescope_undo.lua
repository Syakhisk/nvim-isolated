return {
  {
    "debugloop/telescope-undo.nvim",
    config = function()
      Util.pkg.on_load("telescope.nvim", function()
        require("telescope").load_extension "undo"
      end)
    end,
    keys = {
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo history" },
    },
  },
}
