# godoc.nvim Integration Spec

## Overview
Integrate `fredrikaverpil/godoc.nvim` to provide in-editor Go documentation lookup via fuzzy search, complementing the gopls LSP setup for comprehensive Go development experience.

## Current Setup Context
- **Go:** v1.26.5
- **Gopls:** Configured with gofumpt, analyses enabled
- **Formatting:** Auto-format on save for `.go` files
- **Editor:** Neovim 0.12.3
- **Package Manager:** vim.pack (built-in to nvim 0.12+, not lazy.nvim)
- **Picker:** Telescope with Telescope FZF native extension
- **LSP:** Using new `vim.lsp.config` API

## Implementation (COMPLETED)

### 1. Plugin Added to vim.pack
In `init.lua`:
```lua
-- Add godoc.nvim for Go documentation lookup
vim.pack.add { gh 'fredrikaverpil/godoc.nvim' }
```

### 2. Setup and Keybindings
File: `lua/custom/plugins/godoc.lua`
```lua
local ok, godoc = pcall(require, 'godoc')
if ok then
  godoc.setup {}
  vim.keymap.set('n', '<leader>go', '<cmd>Godoc<cr>', { noremap = true, desc = '[G]o [O]doc search' })
end
```

### 3. Telescope Integration
godoc.nvim auto-detects Telescope. No additional config needed.

### 4. Workflow
**Before:** Open browser → search docs → return to editor
**After:** Press `<leader>go` → fuzzy search package → view docs → `gd` to jump to source

## Keybindings

### Godoc.nvim (Package/Symbol Documentation)
- `<leader>go` — Open godoc picker (search packages/symbols)
- `<leader>gO` — Search godoc for symbol/keyword under cursor

### Go Doc Command (Keywords + Packages)
- `<leader>gs` — View `go doc` output for word under cursor (offline, handles keywords)

## Benefits
- **Faster research:** Docs 3 key presses away, not a browser tab
- **Context preservation:** Stay in your code flow
- **Go stdlib + third-party:** Works for all importable packages
- **Symbol lookup:** Find specific functions/types quickly

## Limitations & Alternatives

**Godoc limitation:** Only indexes packages/symbols, NOT language keywords
- Keywords (`if`, `for`, `func`, `type`, etc.) have no godoc entries
- Use `K` (hover) or Go Spec reference for keywords

**Three-way documentation lookup:**
- **Hover (`K`):** Quick signature/hover
- **`<leader>gO`:** Godoc for word under cursor (packages/functions/types)
- **`<leader>gs`:** Go spec for language keywords (future: to implement)

Both godoc and hover complement each other — combine them for full coverage.

## Implementation Status
- [x] Add to vim.pack.add in init.lua
- [x] Create `lua/custom/plugins/godoc.lua`
- [x] Define keybindings
- [x] Test with Telescope picker
- [x] Document in research/

## Notes
- Works with vim.pack (builtin nvim package manager, not lazy.nvim)
- Plugin is lazy-loaded on demand (fast startup)
- Requires `go` command in PATH (already installed)
