# Nice to have

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
