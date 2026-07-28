# godoc.nvim Integration Spec

## Overview
Integrate `fredrikaverpil/godoc.nvim` to provide in-editor Go documentation lookup via fuzzy search, complementing the gopls LSP setup for comprehensive Go development experience.

## Current Setup Context
- **Go:** v1.26.5
- **Gopls:** Configured with gofumpt, analyses enabled
- **Formatting:** Auto-format on save for `.go` files
- **Editor:** Neovim 0.12.3 with Telescope picker
- **LSP:** Using new `vim.lsp.config` API

## Integration Plan

### 1. Installation
Add to `lua/custom/plugins/godoc.lua`:
```lua
return {
  'fredrikaverpil/godoc.nvim',
  ft = 'go',
  config = function()
    require('godoc').setup({})
  end,
}
```

### 2. Keybindings
Recommended keybindings in godoc config:
- `<leader>go` — Open godoc search (global Go packages)
- `<leader>gO` — Search godoc for symbol under cursor

### 3. Telescope Integration
godoc.nvim auto-detects Telescope if available (already in kickstart). No additional config needed.

### 4. Workflow
**Before:** Open browser → search docs → return to editor
**After:** Press `<leader>go` → fuzzy search package → view docs → `gd` to jump to source

## Benefits
- **Faster research:** Docs 3 key presses away, not a browser tab
- **Context preservation:** Stay in your code flow
- **Go stdlib + third-party:** Works for all importable packages
- **Symbol lookup:** Find specific functions/types quickly

## Alternative: Hover Docs
Note: gopls already provides hover documentation. Compare:
- **Hover (`K`):** Quick reference for symbol under cursor
- **godoc search:** Browse packages/stdlib, discover APIs

Both complement each other.

## Implementation Status
- [ ] Create `lua/custom/plugins/godoc.lua`
- [ ] Define keybindings
- [ ] Test with stdlib packages (fmt, io, etc.)
- [ ] Test with project packages
- [ ] Document keybindings in project

## Risks/Considerations
- Adds one more plugin dependency
- Requires active `go` command in PATH (already have)
- Picker performance with large package sets (rarely an issue)
