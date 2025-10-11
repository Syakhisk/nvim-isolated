local u = require("config.keymaps.util")
local tmux = require("pkg.tmux")

local map = vim.keymap.set

-- Clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy from system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Tmux integration, fallback tmux navigation if nvim split is on edge
map("n", "<c-w>h", tmux.navigate("h"))
map("n", "<c-w>j", tmux.navigate("j"))
map("n", "<c-w>k", tmux.navigate("k"))
map("n", "<c-w>l", tmux.navigate("l"))

-- Save
map("n", "<leader><space>", vim.cmd.w, { desc = "Save file" })

-- Comments
map("n", "<leader>/", "gcc", { desc = "Toggle comments", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comments", remap = true })

-- Format
map({ "n", "v" }, "<leader>lf", Lib.formatter.format, { desc = "Format file" })

-- Select pasted text
map("n", "gp", "`[v`]", { desc = "Select last pasted text" })

-- Duplicate and comment
map("n", "yc", "yygccp", { desc = "Duplicate line and comment the original" })

-- Emacs binding on insert mode (useful for insert-mode-like text input in nui.nvim, telescope, etc)
map({ "i", "c" }, "<c-a>", "<Home>", { desc = "Move cursor to beginning of line" })
map({ "i", "c" }, "<c-b>", "<Left>", { desc = "Move cursor to left" })
map({ "i", "c" }, "<c-e>", "<End>", { desc = "Move cursor to end of line" })
map({ "i", "c" }, "<c-f>", "<Right>", { desc = "Move cursor to right" })
map({ "i", "c" }, "<m-b>", "<c-Left>", { desc = "Move cursor to left word" })
map({ "i", "c" }, "<m-f>", "<c-Right>", { desc = "Move cursor to right word" })

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", u.key_esc, { expr = true, desc = "Escape and Clear hlsearch" })

-- Better up/down (treat wrapped line as different line so navigation not jumps)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Location list
map("n", "<leader>xl", u.loclist, { desc = "Location List" })

-- Quickfix list
map("n", "<leader>xq", u.qflist, { desc = "Quickfix List" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", u.diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", u.diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", u.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", u.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", u.diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", u.diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Redraw ui? not sure what this does
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / Clear hlsearch / Diff Update" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", u.inspec_tree, { desc = "Inspect Tree" })

---@param snacks Snacks
u.with("snacks", function(snacks)
  if vim.fn.executable("lazygit") == 1 then
    map("n", "<leader>gg", snacks.lazygit.open, { desc = "Lazygit Open" })
    map("n", "<leader>gf", snacks.lazygit.log_file, { desc = "Lazygit Current File History" })
    map("n", "<leader>gl", snacks.lazygit.log, { desc = "Lazygit Log Open" })

    -- map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
    -- map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
    -- map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
    -- map("n", "<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log" })
    -- map("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })

    -- map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
    -- map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
    -- map({"n", "x" }, "<leader>gY", function()
    --   Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
    -- end, { desc = "Git Browse (copy)" })
    --
  end

  Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  Snacks.toggle.diagnostics():map("<leader>ud")
  Snacks.toggle.line_number():map("<leader>ul")
  Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
  Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
  Snacks.toggle.treesitter():map("<leader>uT")
  Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  Snacks.toggle.dim():map("<leader>uD")
  Snacks.toggle.animate():map("<leader>ua")
  Snacks.toggle.indent():map("<leader>ug")
  Snacks.toggle.scroll():map("<leader>uS")
  Snacks.toggle.profiler():map("<leader>dpp")
  Snacks.toggle.profiler_highlights():map("<leader>dph")

  if vim.lsp.inlay_hint then
    Snacks.toggle.inlay_hints():map("<leader>uh")
  end
end)

u.with("telescope", function()
  local util = require("plugins.editor.telescope.util")
  local b = require("telescope.builtin")

  u.map("<c-p>", util.find_files(), { desc = "Find Files (root dir)" })
  u.map("<leader>sB", b.builtin, { desc = "Telescope Builtins" })

  u.map("<leader>sf", util.find_files(), { desc = "Find Files (root dir)" })
  u.map("<leader>sj", b.jumplist, { desc = "Telescope Jumps" })
  u.map("<leader>sv", b.git_status, { desc = "Git Status" })
  u.map("<leader>sz", b.spell_suggest, { desc = "Suggest Spelling" })

  u.map("<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Switch Buffer" })

  -- find
  u.map("<leader>bs", b.buffers, { desc = "Buffers" })
  u.map("<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>", { desc = "Buffers" })
  u.map("<leader>fg", b.git_files, { desc = "Find Files (git-files)" })
  u.map("<leader>fr", b.oldfiles, { desc = "Recent" })

  -- git
  u.map("<leader>gc", b.git_commits, { desc = "Commits" })
  u.map("<leader>gs", b.git_status, { desc = "Status" })

  -- search
  u.map('<leader>s"', b.registers, { desc = "Registers" })
  u.map("<leader>sa", b.autocommands, { desc = "Auto Commands" })
  u.map("<leader>sb", b.current_buffer_fuzzy_find, { desc = "Buffer" })
  u.map("<leader>sc", b.command_history, { desc = "Command History" })
  u.map("<leader>sC", b.commands, { desc = "Commands" })
  u.map("<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" })
  u.map("<leader>sD", b.diagnostics, { desc = "Workspace Diagnostics" })
  u.map("<leader>sh", b.help_tags, { desc = "Help Pages" })
  u.map("<leader>sH", b.highlights, { desc = "Search Highlight Groups" })
  u.map("<leader>sj", b.jumplist, { desc = "Jumplist" })
  u.map("<leader>sk", b.keymaps, { desc = "Key Maps" })
  u.map("<leader>sl", b.loclist, { desc = "Location List" })
  u.map("<leader>sM", b.man_pages, { desc = "Man Pages" })
  u.map("<leader>sm", b.marks, { desc = "Jump to Mark" })
  u.map("<leader>so", b.vim_options, { desc = "Options" })
  u.map("<leader>sR", b.resume, { desc = "Resume" })
  u.map("<leader>sq", b.quickfix, { desc = "Quickfix List" })
end)

u.with("neo-tree", function()
  u.map("<leader>e", "<cmd>Neotree toggle reveal=true position=float<cr>", { desc = "Toggle NeoTree" })
  u.map("<leader>E", "<cmd>Neotree toggle reveal=true position=right<cr>", { desc = "Toggle NeoTree (Right)" })
end)

u.with("treesj", function()
  u.map("<leader>Cs", "<cmd>TSJToggle<cr>", { desc = "Splitjoin: toggle" })
  u.map("<leader>Cj", "<cmd>TSJJoin<cr>", { desc = "Splitjoin: join" })
end)

u.with("ssr", function(ssr)
  u.map("<leader>sr", ssr.open, { desc = "Structural Search & Replace" }, { mode = { "v", "n" } })
end)

u.with("bufferline", function()
  u.map("<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
  u.map("<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
  u.map("<c-s-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer previous" })
  u.map("<c-s-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
  u.map("<leader>b0", "<cmd>BufferLineTogglePin<cr>", { desc = "Toggle pin" })
  u.map("<leader>bH", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close buffer to the left" })
  u.map("<leader>bL", "<cmd>BufferLineCloseRight<cr>", { desc = "Close buffer to the right" })
  u.map("<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
  u.map("<leader>bS", "<cmd>BufferLineSortByDirectory<cr>", { desc = "Sort buffer by directory" })
  u.map("<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
  u.map("<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
  u.map("[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
  u.map("[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
  u.map("]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
  u.map("]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

  u.map("<leader>bd", function()
    require("snacks").bufdelete()
  end, { desc = "Delete Buffer" })
  u.map("<leader>bo", function()
    require("snacks").bufdelete.other()
  end, { desc = "Delete Other Buffers" })
end)


u.map("<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown preview" })

u.map("<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" }, { with = "mason" })
u.map("<leader>cl", "<cmd>Lazy<cr>", { desc = "Lazy" }, { with = "lazy" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- -- floating terminal
-- map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })
-- -- Terminal Mappings
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- native snippets. only needed on < 0.11, as 0.11 creates these by default
if vim.fn.has("nvim-0.11") == 0 then
  map("s", "<Tab>", function()
    return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
  end, { expr = true, desc = "Jump Next" })
  map({ "i", "s" }, "<S-Tab>", function()
    return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
  end, { expr = true, desc = "Jump Previous" })
end

-- TODO: this is copied from lazyvim, pick and choose needed ones
-- -- buffers
-- map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>bd", function()
--   Snacks.bufdelete()
-- end, { desc = "Delete Buffer" })
-- map("n", "<leader>bo", function()
--   Snacks.bufdelete.other()
-- end, { desc = "Delete Other Buffers" })
-- map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
--
-- -- windows
-- map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
-- map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
-- map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
-- Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
-- Snacks.toggle.zen():map("<leader>uz")
