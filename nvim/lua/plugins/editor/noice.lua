---@type LazySpec
return {
  {
    "folke/noice.nvim",
    version = "v4.*",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      views = {
        cmdline_popup = {
          position = { row = "0%", col = "50%" },
          size = { width = "auto", height = "auto" },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
        },
        cmdline_popupmenu = {
          position = {
            row = 4,
            col = "50%",
          },
        },
        popupmenu = {
          border = { style = "rounded" },
        },
        hover = {
          border = { style = "rounded" },
        },
        popup = {
          border = { style = "rounded" },
        },
      },
      popupmenu = {
        backend = "nui",
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        lsp_doc_border = true,
        command_pallete = false,
        bottom_search = false,
      },
    },
  },
}
