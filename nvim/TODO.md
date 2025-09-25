# Progress Tracker for Human

## Tracker

> line items tracker

### TODO

- [~] Markdown
  - [x] markdown renderer (neovim+concealls+hlgroup)
    - [x] reduce blinking, is it possible to keep rendering logic on in insert mode while excluding current line (similar to conceal)
    - [x] headings UI adjustment
  - [x] markdown formatter
  - [ ] keymap related to markdown plugins?

### Backlog

- [ ] Spelling
  - Use LSP / nvim native to check for spelling in files
  - See if cased word can be checked as well (e.g. camelcase, pascalcase, etc)
- [ ] Keymaps
  - LazyVim :nohl binds to remove highlights
- [ ] UI improvements
  - Uniformize UI definitions so that plugins can use it (e.g. telescope, neotree, fidget)
- [ ] Buffer management
  - Buffer list
  - Remove multiple buffer (close others, close to left/right)
- [ ] LSP
  - Diagnostics
  - Finish work on keymaps (on attach)
- [ ] AI
  - Copilot completion
  - Copilot chat
    - Try to mimic vscode copilot chat (models, copilot-instructions.md, etc.)

### Done

## Plugin Candidates

> plugins that needs to be installed OR considered to be installed

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

## Floating ideas/concepts

> one-liner (or more) ideas that is came up. If the task is complex, might need to move the line items to tracker section

### Core

- DAP debugger UI #test-debug
- Neotest + Neotests-golang

### QoL

- create comands / keymap to build CLI test commands from nearest test to cursor

### Nice-to-haves
