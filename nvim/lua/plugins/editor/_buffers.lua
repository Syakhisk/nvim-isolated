---@type LazySpec
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "v4.*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/snacks.nvim",
    },
    opts = {
      ---@type bufferline.Options
      options = {
        mode = "buffers",
        -- stylua: ignore
        close_command = function(n) require("snacks").bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("snacks").bufdelete(n) end,
        always_show_bufferline = true,
        diagnostics = "nvim_lsp",
        themable = true,
        diagnostics_indicator = function(_, _, diag)
          local icons = Lib.constants.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "") .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "snacks_layout_box",
          },
        },

        ---@param opts bufferline.IconFetcherOpts
        get_element_icon = function(opts)
          return Lib.constants.icons.ft[opts.filetype]
        end,
      },
      ---@type bufferline.Highlights
      highlights = {},
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<c-s-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer previous" },
      { "<c-s-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "<leader>b0", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
      { "<leader>bH", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffer to the left" },
      { "<leader>bL", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffer to the right" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bS", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort buffer by directory" },
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      -- stylua: ignore
      { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Delete Buffer" },
      -- stylua: ignore
      { "<leader>bo", function() require("snacks").bufdelete.other() end, desc = "Delete Other Buffers" },
    },
  },
  {
    -- Scope buffers to tab
    "tiagovla/scope.nvim",
    opts = {},
    config = function(_, opts)
      Lib.plugins.on_load("telescope.nvim", function()
        -- TODO: setup keymaps for telescope buffer list to default to :Telescope scope buffers
        -- TODO: see if we can include tab indicator in the buffer list
        --  (now it's just shows them without telling which tab it's coming from)
        require("telescope").load_extension("scope")
      end)

      require("scope").setup(opts)
    end,
  },
}
