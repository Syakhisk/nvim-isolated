local M = {}

function M.find_files()
  return function()
    if not vim.fn.executable "rg" then
      require("telescope.builtin").find_files()
      return
    end

    require("telescope.builtin").find_files {
      find_command = {
        "rg",
        "--follow", -- Follow symbolic links
        "--no-ignore-vcs", -- Include files in .gitignore
        "--hidden", -- Search for hidden files
        "--no-heading", -- Don't group matches by each file
        "--files", -- search files instead of content
        "--line-number", -- Show line numbers
        "--column", -- Show column numbers
        "--smart-case", -- Smart case search

        -- Exclude some patterns from search
        "--glob=!**/.git/*",
        "--glob=!**/.idea/*",
        "--glob=!**/.vscode/*",
        "--glob=!**/build/*",
        "--glob=!**/dist/*",
        "--glob=!**/node_modules/*",
        "--glob=!**/.next/*",
        "--glob=!**/yarn.lock",
        "--glob=!**/package-lock.json",
      },
    }
  end
end

M.key_live_grep_actions = function(prompt_bufnr)
  require("telescope-live-grep-args.actions").quote_prompt { postfix = " -g !*mock* -g !*_test.go " }(prompt_bufnr)
end

return M
