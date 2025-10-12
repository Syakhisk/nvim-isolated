local u = require("config.keymaps.util")
local tmux = require("pkg.tmux")

local map = vim.keymap.set

-- Clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy from system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map({ "n" }, "<leader>Y", '"+y$', { desc = "Copy from system clipboard" })
map({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Delete
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete instead of cut" })
map({ "n", "v" }, "<leader>D", '"_D', { desc = "Delete instead of cut " })

-- Delete marks
map("n", "dm", "<cmd>execute 'delmarks '.nr2char(getchar())<cr>", { desc = "Delete mark" })

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
map({ "n", "v" }, "<leader>lf", u.bufferFormat, { desc = "Format file" })

-- Select pasted text
map("n", "gV", "`[v`]", { desc = "Select last pasted text" })

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

-- Better next and prev search
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

-- Smart case renaming for word under cursor
map("n", "<leader>Cr", ":S/<c-r><c-w>//g<left><left>", { desc = "Rename word under cursor (smart case, abolish.vim)" })

-- Insert backtick (avoid triggering tmux prefix)
map("i", "<c-q>", "`", { desc = "Insert backtick" })

-- Split pane (with new buffer)
map("n", "<c-w>V", "<cmd>vnew<cr>", { desc = "Split right (new empty buffer)" })
map("n", "<c-w>S", "<cmd>new<cr>", { desc = "Split down (new empty buffer)" })

-- Focus pane
map("n", "<c-w><Enter>", u.paneToggleSize, { desc = "Toggle maximize/equal panes" })

-- Redraw ui? not sure what this does (redraw might be useful for treesitter)
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / Clear hlsearch / Diff Update" })

-- AST Inspection
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", u.inspec_tree, { desc = "Inspect Tree" })

-- Git
map("n", "<leader>gr", u.projectChangeToGitRoot, { desc = "Change to git root directory" })
map("n", "<leader>gM", u.projectCompareWithMaster, { desc = "Compare with master (neotree & gitsigns change base)" })
map("n", "<leader>gC", u.projectCompareWith, { desc = "Compare with commit/branch (neotree & gitsigns change base)" })

-- Alternate last buffer
map("n", "<c-a>", Lib.wrap(vim.cmd.b, "#"), { desc = "Alternate (last) buffer" })

-- Toggle bufferline
map("n", "<leader>uB", u.bufferlineToggle, { desc = "Toggle bufferline" })

-- Close windowless buffers
map("n", "<leader>bD", "<cmd>CloseWindowlessBuffers<cr>", { desc = "Close hidden buffer (windowless)" })

-- Close window and buffer (buffer unload)
map("n", "<leader>bb", u.splitsCloseAndBufferUnload, { desc = "Unload buffer (close buffer and window)" })

-- Grep
map("n", "gG", u.projectGrepWithContext, { desc = "Go to line" })

-- Folds
map("n", "Zz", Lib.wrap(vim.cmd, "%foldclose"), { desc = "Close all toplevel folds" })
map("n", "Zo", Lib.wrap(vim.cmd, "%foldopen"), { desc = "Open all toplevel folds" })
map("n", "ZZ", "<cmd>setlocal foldlevel=0<cr>", { desc = "Close all folds recursively" })
map("n", "ZO", "<cmd>setlocal foldlevel=99<cr>", { desc = "Open all folds recursively" })

-- Save as root (doesn't work on mac)
map("ca", "w!!", "w !sudo -A tee '%'", { desc = "Save file as root" })

-- Get/set filetype of current buffer
map("n", "<leader>bf", u.bufferGetFiletype, { desc = "Get filetype of current buffer" })
map("n", "<leader>bF", u.bufferSetFiletype, { desc = "Set filetype of current buffer" })

-- Add undo break-points
local breakpoints = ".,;([<{}>])"
for i = 1, #breakpoints do
  local ch = breakpoints:sub(i, i)
  map("i", ch, ch .. "<c-g>u")
end

-- native snippets. only needed on < 0.11, as 0.11 creates these by default
if vim.fn.has("nvim-0.11") == 0 then
  map("s", "<Tab>", function()
    return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
  end, { expr = true, desc = "Jump Next" })
  map({ "i", "s" }, "<S-Tab>", function()
    return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
  end, { expr = true, desc = "Jump Previous" })
end

--
-- Plugins
--

---- LSP ----
---@param snacks Snacks
u.with({ "snacks" }, function(snacks)
  Lib.lsp.on_attach(function(client, buffer)
    local lspmap = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = buffer, desc = "LSP: " .. desc })
    end

    local b = require("telescope.builtin")

    lspmap("gd", Lib.wrap(b.lsp_definitions, { reuse_win = false, show_line = false }), "[G]oto [D]efinition")
    lspmap("gr", Lib.wrap(b.lsp_references, { reuse_win = false, show_line = false, include_current_line = false }), "[G]oto [R]eferences")
    lspmap("gi", Lib.wrap(b.lsp_implementations, { reuse_win = false, show_line = false }), "[G]oto [I]implementation")
    lspmap("gy", Lib.wrap(b.lsp_type_definitions, { reuse_win = false }), "[G]oto T[y]pe definition")
    lspmap("K", vim.lsp.buf.hover, "Hover")
    lspmap("gK", vim.lsp.buf.signature_help, "Signature help")
    lspmap("]]", Lib.wrap(snacks.words.jump, vim.v.count1), "Next reference")
    lspmap("[[", Lib.wrap(snacks.words.jump, -vim.v.count1), "Prev reference")
    lspmap("<C-S>", vim.lsp.buf.signature_help, "Signature help", { "i", "s" })
    lspmap("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
    lspmap("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
    lspmap("<leader>cc", vim.lsp.codelens.run, "Run Codelens", { "n", "v" })
    lspmap("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
    lspmap("<leader>cR", snacks.rename.rename_file, "Rename file")
    lspmap("<leader>cA", Lib.wrap(vim.lsp.buf.code_action, { apply = true, context = { only = { "source" } } }), "Source action")

    -- { "gD", "<cmd>Lspsaga peek_definition<cr>", desc = "LSP: Peek Definition" },
    -- { "gY", "<cmd>Lspsaga peek_type_definition<cr>", desc = "LSP: Peek Definition" },
    -- { "gR", "<cmd>Lspsaga finder ref<cr>", desc = "LSP: Find References" },
    -- { "gI", "<cmd>Lspsaga finder imp<cr>", desc = "LSP: Find Implementations" },

    ------@type snacks.picker.lsp.Config
    ---local picker_opts = {
    ---  include_current = false,
    ---}
    ---
    ---lspmap("gd", Lib.wrap(snacks.picker.lsp_definitions, picker_opts), "[G]oto [D]efinition")
    ---lspmap("gD", Lib.wrap(snacks.picker.lsp_definitions, picker_opts), "[G]oto [D]efinition")
    ---lspmap("gr", Lib.wrap(snacks.picker.lsp_references, picker_opts), "[G]oto [R]eferences")
    ---lspmap("gi", Lib.wrap(snacks.picker.lsp_implementations, picker_opts), "[G]oto [I]implementation")
    ---lspmap("gy", Lib.wrap(snacks.picker.lsp_type_definitions, { include_current = true }), "[G]oto T[y]pe definition")
  end)
end)

---- Testing ----

---@param neotest neotest
u.with("neotest", function(neotest)
  u.map("<leader>t", "", { desc = "+test" })

  local runfile = function()
    neotest.run.run(vim.fn.expand("%"))
  end

  local runcwd = function()
    neotest.run.run(vim.uv.cwd())
  end

  local togglewatch = function()
    neotest.watch.toggle(vim.fn.expand("%"))
  end

  u.map("<leader>tt", runfile, { desc = "Run File (Neotest)" })
  u.map("<leader>tT", runcwd, { desc = "Run All Test Files (Neotest)" })
  u.map("<leader>tr", neotest.run.run, { desc = "Run Nearest (Neotest)" })
  u.map("<leader>tl", neotest.run.run_last, { desc = "Run Last (Neotest)" })
  u.map("<leader>ts", neotest.summary.toggle, { desc = "Toggle Summary (Neotest)" })
  u.map("<leader>to", Lib.wrap(neotest.output.open, { enter = true, auto_close = true }), { desc = "Show Output (Neotest)" })
  u.map("<leader>tO", neotest.output_panel.toggle, { desc = "Toggle Output Panel (Neotest)" })
  u.map("<leader>tS", neotest.run.stop, { desc = "Stop (Neotest)" })
  u.map("<leader>tw", togglewatch, { desc = "Toggle Watch (Neotest)" })
  u.map("<leader>td", Lib.wrap(neotest.run.run, { strategy = "dap" }), { desc = "debug nearest (Neotest)" })
end)

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

  u.map("<leader>bd", snacks.bufdelete.delete, { desc = "Delete Buffer" })
  u.map("<leader>bo", snacks.bufdelete.other, { desc = "Delete Other Buffers" })
  u.map("<leader>un", snacks.notifier.hide, { desc = "Dismiss All Notifications" })

  snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  snacks.toggle.diagnostics():map("<leader>ud")
  snacks.toggle.line_number():map("<leader>ul")
  snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
  snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
  snacks.toggle.treesitter():map("<leader>uT")
  snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  snacks.toggle.dim():map("<leader>uD")
  snacks.toggle.animate():map("<leader>ua")
  snacks.toggle.indent():map("<leader>ug")
  snacks.toggle.scroll():map("<leader>uS")
  snacks.toggle.profiler():map("<leader>dpp")
  snacks.toggle.profiler_highlights():map("<leader>dph")

  if vim.lsp.inlay_hint then
    snacks.toggle.inlay_hints():map("<leader>uh")
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

  u.map("[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
  u.map("]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
  u.map("[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
  u.map("]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

  u.map("<leader>b0", "<cmd>BufferLineTogglePin<cr>", { desc = "Toggle pin" })
  u.map("<leader>bH", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close buffer to the left" })
  u.map("<leader>bL", "<cmd>BufferLineCloseRight<cr>", { desc = "Close buffer to the right" })
  u.map("<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
  u.map("<leader>bS", "<cmd>BufferLineSortByDirectory<cr>", { desc = "Sort buffer by directory" })
  u.map("<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
  u.map("<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
end)

-- Open UIs
u.map("<leader>w", "", { desc = "+plugin windows" })
u.map("<leader>wp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown preview" })
u.map("<leader>wm", "<cmd>Mason<cr>", { desc = "Mason" }, { with = "mason" })
u.map("<leader>wl", "<cmd>Lazy<cr>", { desc = "Lazy" }, { with = "lazy" })
u.map("<leader>wc", "<cmd>Conform<cr>", { desc = "Conform" }, { with = "conform" })
u.map("<leader>wL", Snacks.picker.lsp_config, { desc = "LSP: show info" })

-- -- floating terminal
-- map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })
-- -- Terminal Mappings
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- TODO: toolbox
-- -- Jetbrains Toolbox Golang URL
-- --stylua: ignore start
-- require("m42nk/toolbox").setup()
-- vim.keymap.set( "n", "<leader>gty", require("m42nk/toolbox").copy_to_clipboard, { desc = "Copy current line location in GoLand URL" })
-- vim.keymap.set( "n", "<leader>gto", require("m42nk/toolbox").open_in_toolbox, { desc = "Open current line location in GoLand URL" })
-- vim.keymap.set( "n", "<leader>g<Enter>", require("m42nk/toolbox").open_in_toolbox, { desc = "Open current line location in GoLand URL" })
-- --stylua: ignore end
