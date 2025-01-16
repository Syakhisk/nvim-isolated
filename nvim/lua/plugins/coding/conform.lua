return {
  "stevearc/conform.nvim",
  ---@type conform.setupOpts
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
      stop_after_first = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },

      -- lua = { "stylua" },
      -- -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      -- -- You can customize some of the format options for the filetype (:help conform.format)
      -- rust = { "rustfmt", lsp_format = "fallback" },
      -- -- Conform will run the first available formatter
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
