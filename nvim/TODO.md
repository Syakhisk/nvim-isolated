# Progress Tracker for Human

## Tracker

> line items tracker

### Active

- [ ] Keymaps
  - see Keymaps section at the bottom

### Backlog

- [ ] Spelling
  - Use LSP / nvim native to check for spelling in files
  - See if cased word can be checked as well (e.g. camelcase, pascalcase, etc)

- [ ] Statusline
- [~] Buffer management
  - Buffer list
  - Remove multiple buffer (close others, close to left/right)
  - ideas:
    - use window position to sort buffer (left buffer should be moved left, etc)
    - or, each window has separate bufferlist (see if this possible)
    - experiment between buflist and buffer statusbar
  - Plugin candidate:
    - EL-MASTOR/bufferlist.nvim
    - francescarpi/buffon.nvim
    - romgrk/barbar.nvim
    - akinsho/bufferline.nvim

- [ ] UI improvements
  - Dashboard
  - Statusbar
    - macro recording indicator
    - background job indicator (markdown preview, dap attach)
  - Uniformize UI definitions so that plugins can use it (e.g. telescope, neotree, fidget)
  - [x] Indent blanklines (use snacks?)
  - [x] Popup Notifier
    - Regular msg / notification
    - Confirmation dialog on load file, confirm exit/save, etc
  - [x] Popup Cmdline

- [ ] LSP
  - Diagnostics

- [ ] AI
  - Copilot completion
  - Copilot chat
    - Try to mimic vscode copilot chat (models, copilot-instructions.md, etc.)

- [ ] nvim-lint
  - is it needed?

## Plugin Candidates

> plugins that needs to be installed OR considered to be installed

- [ ] https://github.com/hangyav/textLSP
  - for spelling
- [ ] folke/flash.nvim
  - multichars jumps throughout windows (code navigation on steroid )
- [ ] aerial.nvim
  - plugins for LSP symbols outline
  - my usecase: better lsp_document_symbols as it highlights nearest function from cursor instead of top-bottom
- [ ] folke/trouble.nvim
  - better qflist / lists in general
  - my usecase: see if it's possible / make sense to replace default qflist with trouble
- [ ] SchemaStore.nvim
  - json schema to accompany lsps for json, yaml, etc. so that it provides autocompletes if schema is present online (e.g. for docker-compose, etc.)
- [ ] folke/snacks.nvim
  - QoL plugins for nvim, e.g. renamer, indent blankline, buffer management, etc.
- [ ] ofirgall/open.nvim
  - open shorthand, can be customized (e.g. create custom opener for file to be opened in jetbrains)
- [ ] lewis6991/gitsigns.nvim
  - git related info, try configuring it
- [x] tpope/abolish.vim

## Floating ideas/concepts

> one-liner (or more) ideas that is came up. If the task is complex, might need to move the line items to tracker section

### Things

- show notification while running long tasks, e.g. conform / lsp formatting (useful in golang while fixing import)
- auto root + keymap to change root back to project
- DAP debugger UI #test-debug
- Neotest + Neotests-golang
- create comands / keymap to build CLI test commands from nearest test to cursor
- multicursors????
- session save (what to save on close)

### Keymaps

NOTE:

> Should plugin keymaps be placed in plugin specs or keymaps.lua?
>
> - if yes, need a way to check if plugins is installed, use lazy methods or create util function

- [ ] `cia` change inner arguments + other treesitter wise keymaps
- [ ] `vaq` select outer quotes
- [ ] `<leader>cr` LSP rename
- [ ] folding
- [x] LazyVim :nohl binds to remove highlights

### Done

- [x] LazySpec auto file template
  - use autocommands

- [x] Markdown
  - [x] markdown renderer (neovim+concealls+hlgroup)
    - [x] reduce blinking, is it possible to keep rendering logic on in insert mode while excluding current line (similar to conceal)
    - [x] headings UI adjustment
  - [x] markdown formatter
