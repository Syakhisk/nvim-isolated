return {
  {
    "debugloop/telescope-undo.nvim",
    config = function()
      Lib.plugins.on_load("telescope.nvim", function()
        require("telescope").load_extension("undo")
      end)
    end,
    -- TODO: keymaps here
    keys = {
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo history" },
    },
  },
}
