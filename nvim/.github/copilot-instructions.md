# Neovim Configuration AI Instructions

This is a highly modular Neovim configuration using Lazy.nvim plugin manager. Understanding the architectural patterns is crucial for effective contributions.

> **⚡ ALWAYS CHECK FIRST:** See `.github/PROGRESS.md` for current development status, active TODOs, and completion priorities before making any suggestions or changes.

## Architecture Overview

### Core Bootstrap Pattern
- `init.lua` establishes global libraries (`_G.Lib`, `_G.Globals`) before loading configuration modules
- Configuration loading order is critical: options → lazy → keymaps → abbreviations → autocmds
- All configuration modules are in `lua/config/` and loaded sequentially from `init.lua`

### Library System (`lua/lib/`)
- `lib/init.lua` uses lazy-loading metatable pattern: modules auto-loaded when accessed via `Lib.module_name`
- Global `_G.Lib` provides utilities across the entire configuration
- Key libraries: `loader` (auto-require), `formatter`, `strings`, `log`, `modules`, `globals`
- Always use `Lib.module_name` syntax, never direct require for library access

### Plugin Architecture (`lua/plugins/`)
- Plugins auto-discovered using `Lib.loader.require_all(2)` in `plugins/init.lua` 
- Supports nested directory structures (2 levels deep) with automatic detection
- Each plugin file returns Lazy.nvim spec array, allowing multiple plugins per file
- Plugin organization: `coding/`, `editor/` subdirectories for categorization

## Plugin Configuration Patterns

### Standard Plugin Spec Structure
```lua
return {
  "plugin/name",
  dependencies = { "dep1", "dep2" },
  opts = {}, -- preferred over config for simple setups
  config = function() end, -- for complex initialization
  keys = {}, -- lazy-load on keybindings
  init = function() end, -- runs immediately, before plugin loads
}
```

### Key Patterns Found
- **Multi-plugin files**: Single file can return array with multiple plugin specs (see `treesitter.lua`)
- **Conditional URL loading**: Use `url = "https://..."` for non-GitHub repos
- **Nested dependencies**: Complex plugins like Telescope include deps as separate files in `deps/` subdirectories
- **Keymap integration**: Most plugins define keys in plugin spec for lazy loading

### Plugin Dependencies Organization
- Complex plugins (like Telescope) have dedicated subdirectories with `util.lua`, `layout.lua` helpers
- Dependencies in `deps/` subdirectory when they need custom configuration
- Use relative requires from plugin files: `require("plugins.editor.telescope.util")`

## Development Workflows

### Code Formatting
- **StyLua** configured via `stylua.toml` with 200 char width, 2-space indentation, double quotes
- Format command: `<leader>lf` mapped to `Lib.formatter.format`
- Always format before commits using the configured style

### File Structure Conventions
- Use `init.lua` files for modules that need to export multiple items or coordinate loading
- Utility files named descriptively (`util.lua`, `layout.lua`, `keymaps.lua`)
- Plugin files named after main plugin (e.g., `blink.lua` for blink.cmp plugin)

### Tmux Integration Pattern
- Navigation keymaps (`<c-w>h/j/k/l`) fall back to Tmux pane navigation at edges
- Handled by `pkg.tmux.navigate()` function for seamless split/pane switching

## Configuration Conventions

### Keymap Patterns
- Leader key: `<space>` (global), `\` (local leader)
- Namespace prefixes: `<leader>s` (search), `<leader>f` (find), `<leader>g` (git), `<leader>l` (LSP)
- Always include `desc` parameter for keymap documentation
- Use `remap = true` for keymaps that should chain (like comment toggling)

### Options Philosophy  
- Sensible defaults in `config/options.lua`: no swap files, persistent undo, 2-space tabs
- Performance focused: disable unused RTP plugins in Lazy config
- UI consistency: rounded borders, specific colorcolumn at 100, cursor line highlighting

### Global Access Pattern
- `_G.Lib` and `_G.Globals` established early for configuration-wide access
- Prefer `Lib.module` over direct requires for consistency
- Libraries are lazy-loaded - only accessed modules get required

## Plugin-Specific Notes

### Completion (Blink.cmp)
- Replaces nvim-cmp (migration in progress per TODO.md)
- Uses "enter" preset for keymap, signature help enabled
- Custom icon/highlight integration with nvim-web-devicons and lspkind

### Telescope
- Bottom pane layout strategy preferred (`bottom_pane`)
- Custom keymaps override defaults for selection/preview toggling
- Extensive keymap definitions for different picker types
- Live grep args extension for advanced search patterns

### LSP Configuration
- Mason for tool management with mason-lspconfig integration
- LSP keymaps defined in separate `nvim-lspconfig/keymaps.lua` module
- Per-buffer attachment pattern (referenced in TODO but implementation location varies)

## Essential Files to Reference
- **`.github/PROGRESS.md`** - Current development status, active TODOs, and completion tracking
- **`TODO.md`** - Human-written TODO file, try to check this TODO file and sync the progress with PROGRESS.md, prioritize newer update in TODO file, if there are any discrepancies, prompt the user to update either file
- Check these files before making suggestions to understand current priorities and avoid duplicate work

## Progress Tracking Workflow
When making significant changes to the codebase:
1. **Always check** `.github/PROGRESS.md` first to understand current sprint priorities
2. **Update progress** after completing tasks - move items from "In Progress" to "Completed"
3. **Add new TODOs** discovered during development to appropriate sections
4. **Update progress metrics** if major milestones are reached

Use this prompt to update progress: `"Update .github/PROGRESS.md based on recent changes to [specific files/features]"`

## TODO Management
- **Primary**: `.github/PROGRESS.md` tracks current development status with priority levels
- **Legacy**: `TODO.md` contains historical items (reference for context only)
- **Current focus**: Completing blink.cmp migration, LSP setup, diagnostics
- **Code TODOs**: Address inline TODO comments when working on related features

When contributing, respect the modular architecture, use the established library system, and follow the plugin organization patterns. Always test configuration changes in isolation before integration.
