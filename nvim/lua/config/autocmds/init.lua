local autocmd = require("config.autocmds.util").autocmd
local augroup = require("config.autocmds.util").augroup

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("yank-highlight"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Set Go file specific options
autocmd("FileType", {
  group = augroup("golang"),
  pattern = { "go" },
  callback = function()
    vim.opt.expandtab = false
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
  end,
})

-- Adjust window layout for help and man pages
-- Place these window on the right side
autocmd("FileType", {
  group = augroup("man_positioning"),
  pattern = { "help", "man" },
  callback = function()
    if vim.api.nvim_win_get_width(0) > 110 then
      vim.cmd.wincmd("L")
    end
  end,
})

-- TODO: don't we need augroup here?
-- Set filetype for .yml.sample files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.yml.sample",
  command = "set filetype=yaml",
})

-- don't continue comments on new lines using o and O
autocmd("FileType", {
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
})

-- TODO: is this needed?
-- -- Highlight trailing whitespace except in certain file types
-- autocmd({ "FileType", "InsertEnter", "InsertLeave" }, {
--   group = augroup("trailing_whitespace"),
--   pattern = { "*" },
--   callback = require("config.autocmds.trailing_whitespace").callback,
-- })

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].suntinx_last_loc then
      return
    end
    vim.b[buf].suntinx_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
