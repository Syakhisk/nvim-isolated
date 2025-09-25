---@type LazySpec
return {
  -- Markdown renderer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = {
        lsp = { enabled = true },

        -- TODO: check if this is needed since it mentioned in the docs that blink is automatically enabled
        blink = { enabled = true },
      },
      render_modes = { "n", "c", "t", "i" },
      heading = {
        border = { false },

        position = "inline",
        left_pad = { 2, 4, 6, 8 },

        width = { "full", "block" },
        min_width = { 0, 90, 60, 30 },

        sign = true,

        icons = { "H1 ", "H2 ", "H3 ", "H4 ", "H5 ", "H6 " },

        -- TODO: colors
        -- backgrounds = {
        --     'RenderMarkdownH1Bg',
        --     'RenderMarkdownH2Bg',
        --     'RenderMarkdownH3Bg',
        --     'RenderMarkdownH4Bg',
        --     'RenderMarkdownH5Bg',
        --     'RenderMarkdownH6Bg',
        -- },
        -- foregrounds = {
        --     'RenderMarkdownH1',
        --     'RenderMarkdownH2',
        --     'RenderMarkdownH3',
        --     'RenderMarkdownH4',
        --     'RenderMarkdownH5',
        --     'RenderMarkdownH6',
        -- },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettier" } },
  },
}
