vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


vim.opt.number = true
vim.opt.mouse = "a"

vim.opt.showmode = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = "100"

vim.opt.scrolloff = 10

vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap

vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true

-- vim.opt.breakindent = true
-- vim.opt.updatetime = 250
-- vim.opt.timeoutlen = 300
