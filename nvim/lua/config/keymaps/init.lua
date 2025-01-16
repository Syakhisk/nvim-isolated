-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Tmux integration, fallback tmux navigation if nvim split is on edge
vim.keymap.set("n", "<c-w>h", require("lib.tmux").navigate("h"))
vim.keymap.set("n", "<c-w>j", require("lib.tmux").navigate("j"))
vim.keymap.set("n", "<c-w>k", require("lib.tmux").navigate("k"))
vim.keymap.set("n", "<c-w>l", require("lib.tmux").navigate("l"))

-- Save
vim.keymap.set("n", "<leader><space>", vim.cmd.w, { desc = "Save file" })

-- Comments
vim.keymap.set("n", "<leader>/", "gcc", { desc = "Toggle comments", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "Toggle comments", remap = true })

-- Format
vim.keymap.set({ "n", "v" }, "<leader>lf", Util.formatter.format, { desc = "Format file" })


-- if vim.fn.executable("lazygit") == 1 then
--   map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
--   map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
--   map("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
--   map("n", "<leader>gl", function() Snacks.lazygit.log({ cwd = LazyVim.root.git() }) end, { desc = "Lazygit Log" })
--   map("n", "<leader>gL", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })
-- end
