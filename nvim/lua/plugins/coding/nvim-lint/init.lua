---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  opts = {
    -- Event to trigger linters
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      -- ["*"] = { "cspell" },
      markdown = { "markdownlint-cli2" },
      docker = { "hadolint" },
    },
  },
  -- TODO: fix linting logic related to filetype checks and cspell
  config = function(_, opts)
    local lint = require("lint")
    opts.linters = opts.linters or {}

    -- Change severity of cspell
    if opts.linters.cspell then
      opts.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.HINT
        return diagnostic
      end)
    end

    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        if type(linter.prepend_args) == "table" then
          lint.linters[name].args = lint.linters[name].args or {}
          vim.list_extend(lint.linters[name].args, linter.prepend_args)
        end
      else
        lint.linters[name] = linter
      end
    end

    lint.linters_by_ft = opts.linters_by_ft

    local u = require("plugins.coding.nvim-lint.utils")

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = u.debounce(100, u.lint),
    })
  end,
}
