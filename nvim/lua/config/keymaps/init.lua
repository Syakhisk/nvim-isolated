-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Tmux integration, fallback tmux navigation if nvim split is on edge
vim.keymap.set("n", "<c-w>h", require("pkg.tmux").navigate("h"))
vim.keymap.set("n", "<c-w>j", require("pkg.tmux").navigate("j"))
vim.keymap.set("n", "<c-w>k", require("pkg.tmux").navigate("k"))
vim.keymap.set("n", "<c-w>l", require("pkg.tmux").navigate("l"))

-- Save
vim.keymap.set("n", "<leader><space>", vim.cmd.w, { desc = "Save file" })

-- Comments
vim.keymap.set("n", "<leader>/", "gcc", { desc = "Toggle comments", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "Toggle comments", remap = true })

-- Format
vim.keymap.set({ "n", "v" }, "<leader>lf", Lib.formatter.format, { desc = "Format file" })

-- Select pasted text
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })

-- Duplicate and comment
vim.keymap.set("n", "yc", "yygccp", { desc = "Duplicate line and comment the original" })

-- Emacs binding on insert mode (useful for insert-mode-like text input in nui.nvim, telescope, etc)
vim.keymap.set({ "i", "c" }, "<c-a>", "<Home>", { desc = "Move cursor to beginning of line" })
vim.keymap.set({ "i", "c" }, "<c-b>", "<Left>", { desc = "Move cursor to left" })
vim.keymap.set({ "i", "c" }, "<c-e>", "<End>", { desc = "Move cursor to end of line" })
vim.keymap.set({ "i", "c" }, "<c-f>", "<Right>", { desc = "Move cursor to right" })
vim.keymap.set({ "i", "c" }, "<m-b>", "<c-Left>", { desc = "Move cursor to left word" })
vim.keymap.set({ "i", "c" }, "<m-f>", "<c-Right>", { desc = "Move cursor to right word" })
