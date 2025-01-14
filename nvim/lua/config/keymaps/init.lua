-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Tmux integration, fallback tmux navigation if nvim split is on edge
vim.keymap.set("n", "<c-w>h", require("lib.tmux").navigate "h")
vim.keymap.set("n", "<c-w>j", require("lib.tmux").navigate "j")
vim.keymap.set("n", "<c-w>k", require("lib.tmux").navigate "k")
vim.keymap.set("n", "<c-w>l", require("lib.tmux").navigate "l")

-- Save
vim.keymap.set("n", "<leader><space>", vim.cmd.w, { desc = "Save file" })

-- Comments
-- vim.keymap.set("

-- Format
-- (simple)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
