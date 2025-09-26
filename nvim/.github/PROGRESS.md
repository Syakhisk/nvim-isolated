# Neovim Configuration Progress Tracker

> **Last Updated:** September 25, 2025  
> **Status:** Active Development - Mid-transition from nvim-cmp to blink.cmp

## 🎯 Current Sprint (High Priority)

### 🚧 In Progress
- [ ] **Completion System Migration** 
  - [x] ✅ Set up blink.cmp with basic configuration
  - [x] ✅ Configure signature help for blink.cmp
  - [ ] ❌ Remove nvim-cmp files (`lua/plugins/coding/nvim-cmp/` directory still exists, marked DEPRECATED)
  - [ ] ❌ Set up modified supertab keymap behavior for blink.cmp
  - [ ] ❌ Verify blink.cmp LSP integration works correctly

- [ ] **LSP Configuration** 
  - [x] ✅ Basic Mason + mason-lspconfig setup
  - [x] ✅ Fidget LSP progress indicator
  - [ ] ❌ Complete LSP on_attach keymaps (found incomplete TODOs in `keymaps.lua`)
  - [ ] ❌ Document highlighting and reference clearing
  - [ ] ❌ Inlay hints toggle functionality

### 🔥 Critical Issues (Found in Code)
- [ ] **Code TODOs to Address:**
  - [ ] `telescope/init.lua:99` - Move live grep args extension configuration 
  - [ ] `telescope/layout.lua:69` - Optimize layout creation performance
  - [ ] `autocmds/init.lua:35` - Determine if augroup needed for yml.sample files
  - [ ] `autocmds/init.lua:49` - Evaluate if trailing whitespace autocmd is needed
  - [ ] `nvim-lspconfig/keymaps.lua:32,52` - Complete LSP keymap implementations

## ✅ Completed Features

### Core Functionality
- [x] ✅ **Telescope** - File finder with bottom pane layout, live grep args, undo history
- [x] ✅ **Treesitter** - Syntax highlighting, incremental selection, text objects
- [x] ✅ **Auto pairs** - Smart bracket/quote insertion with nvim-autopairs
- [x] ✅ **Comments** - Context-aware commenting with ts-comments
- [x] ✅ **Formatting** - StyLua integration via conform.nvim
- [x] ✅ **Git Integration** - Lazygit via snacks.nvim
- [x] ✅ **File Explorer** - Neo-tree with floating window configuration

### Infrastructure
- [x] ✅ **Plugin System** - Lazy.nvim with auto-discovery up to 2 levels
- [x] ✅ **Library System** - `_G.Lib` metatable with lazy-loading modules
- [x] ✅ **Configuration Structure** - Modular loading order (options → lazy → keymaps → abbrevs → autocmds)
- [x] ✅ **Tmux Integration** - Seamless navigation between vim splits and tmux panes

## 📋 Next Phase (Medium Priority)

### Core Features
- [ ] **Diagnostics System** - LSP diagnostics display and navigation
- [ ] **Yank Highlighting** - Visual feedback for yank operations (autocmd exists but needs verification)
- [ ] **Buffer Management** - Buffer keymaps (bo, bl, bL, etc) and listing

### UI Enhancements
- [ ] **AI Integration** - Copilot completion and chat (mimicking vscode copilot chat with models, copilot-instructions.md)
- [ ] **Popup UI** - Command line and confirmation popups (confirmation dialog on load file, confirm exit/save)
- [ ] **Status Bar** - Custom status line with macro recording indicator and background job indicator
- [ ] **Dashboard** - Simple startup dashboard
- [ ] **Popup Notifier** - Regular msg/notification system

### Core Tools
- [ ] **Buffer Management** - Buffer list, close operations (close others, close to left/right)
- [ ] **Spelling System** - LSP/nvim native spelling checks including camelCase/PascalCase words
- [ ] **Keymaps Enhancement** - LazyVim :nohl binds to remove highlights

## 🔮 Future Enhancements (Low Priority)

### Quality of Life
- [ ] **UI Theming** - Refactor telescope UI to reuse globals/colors util, uniformize UI definitions for plugins
- [ ] **DAP Viewer** - Simple debug adapter protocol viewer and debugger UI
- [ ] **Neotest Integration** - Test framework with Neotest + Neotests-golang
- [ ] **CLI Test Commands** - Commands/keymaps to build CLI test commands from nearest test to cursor

### Plugin Candidates (Under Evaluation)
- [ ] **Flash.nvim** - Multi-char jumps throughout windows for enhanced code navigation
- [ ] **Aerial.nvim** - LSP symbols outline with nearest function highlighting from cursor
- [ ] **Trouble.nvim** - Enhanced quickfix list and better list management in general  
- [ ] **SchemaStore.nvim** - JSON/YAML schema support for LSPs (docker-compose, etc.)

### Development Tools
- [ ] **Recording Indicator** - More prominent macro recording indicator  
- [ ] **LSP Spelling** - Spell checking via LSP
- [ ] **Neo-tree LSP** - Autocommands for LSP operations on file moves/renames

### Optimization
- [ ] **Lazy Loading** - Add "lazy" flag to plugins that don't need immediate setup
- [ ] **Telescope Preview** - Remove unneeded preview for certain pickers
- [ ] **Blink.cmp UI** - Visual adjustments for completion menu

## 🐛 Known Quirks & Issues

### Bugs to Fix
- [ ] **Telescope Insert Mode Jump** - File pickers sometimes jump to insert mode unexpectedly
- [ ] **System Clipboard** - Yank to system clipboard not properly configured

### Code Quality
- [ ] **HACK in nvim-cmp/utils.lua:28** - Gopls workaround for completion text matching
- [ ] **Deprecated nvim-cmp** - Remove entire `nvim-cmp/` directory after migration complete

## 📊 Progress Metrics

**Overall Completion:** ~70% of core functionality  
**Current Focus:** Completion system migration (60% done)  
**Next Milestone:** Complete LSP configuration (estimated 2-3 sessions)

### Plugin Status
| Plugin | Status | Notes |
|--------|---------|-------|
| Telescope | ✅ Complete | Bottom pane layout, live grep args |
| Treesitter | ✅ Complete | All features configured |
| Blink.cmp | 🚧 Active | Basic setup done, keymap migration pending |
| LSP | 🚧 Active | Basic setup done, keymaps incomplete |
| Neo-tree | ✅ Complete | Float window with custom keymaps |
| Snacks (Git) | ✅ Complete | Lazygit integration working |
| nvim-cmp | ⚠️ Deprecated | Disabled but files still exist |

---

## 📝 Notes for AI Agents

- This configuration uses a unique auto-discovery plugin system via `Lib.loader.require_all(2)`
- Always use `Lib.module_name` syntax instead of direct requires
- Format code with StyLua before committing (200 char width, 2-space indent)
- Test plugin changes in isolation using the modular architecture
- Check TODOs in code comments when working on related features