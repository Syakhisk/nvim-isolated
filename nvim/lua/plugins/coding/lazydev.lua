---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",

  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks", "snacks" } },
      { path = "nui.nvim", words = { "nui" } },
      "lazy.nvim",
    },
  },
}
