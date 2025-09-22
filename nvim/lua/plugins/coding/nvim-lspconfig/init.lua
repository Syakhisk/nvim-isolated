return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },

      -- auto install for lsps
      { "mason-org/mason-lspconfig.nvim", opts = {
        ensure_installed = { "lua_ls" },
      } },

      -- auto install for non-lsp tools e.g. golangci_lint, stylua, etc
      { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = {
        ensure_installed = { "stylua" },
      } },

      -- Loader UI indicator for LSP
      { "j-hui/fidget.nvim", opts = {} },

      -- "hrsh7th/cmp-nvim-lsp",
      { "saghen/blink.cmp" },
    },
    config = function(_, opts)
      require("plugins.coding.nvim-lspconfig.keymaps").setup_on_attach()

      -- On Neovim 0.11+ with vim.lsp.config, you may skip this step. See nvim-lspconfig docs (https://cmp.saghen.dev/installation#lazy-nvim)
      -- local lspconfig = require("lspconfig")
      -- for server, config in pairs(opts.servers) do
      --   config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      --   lspconfig[server].setup(config)
      -- end
    end,
  },
}
