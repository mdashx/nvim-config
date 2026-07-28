# Kickstart.nvim Packages Overview

## Quick Reference
This document lists all packages in kickstart.nvim with short descriptions. **Read this before adding new research or plugins** to understand what's already available.

---

## Core UI & Navigation

### nvim-telescope/telescope.nvim
**Purpose:** Fuzzy finder for files, buffers, grep, LSP, and more  
**Usage:** `<leader>s*` keybindings (search help, keymaps, files, grep)  
**Replaces:** fzf, ctrlp, other search tools  
**Impact:** Central navigation tool — high priority  

### nvim-telescope/telescope-fzf-native.nvim
**Purpose:** FZF native sorter for Telescope (faster, better sorting)  
**Dependency:** Requires `make` command  
**Usage:** Auto-loaded by Telescope  
**Note:** Conditional install (only if `make` available)  

### nvim-telescope/telescope-ui-select.nvim
**Purpose:** Use Telescope as UI for vim.ui.select  
**Usage:** Makes LSP dialogs, codeactions, etc. use Telescope picker  
**Impact:** Better UI consistency across neovim  

### folke/which-key.nvim
**Purpose:** Shows available keybindings after leader key press  
**Usage:** Press `<leader>` and wait to see all mappings  
**Keybinding metadata:** Automatically picks up from `desc` fields  
**Impact:** Discoverability of keybindings  

---

## Editing & Completion

### saghen/blink.cmp
**Purpose:** Fast completion engine  
**Provides:** Autocomplete with LSP, snippets, buffer sources  
**Usage:** Automatic in insert mode  
**Replaces:** nvim-cmp (old completion plugin)  
**Impact:** Code completion quality and speed  

### L3MON4D3/LuaSnip
**Purpose:** Snippet engine  
**Usage:** Snippets trigger in autocomplete  
**Paired with:** friendly-snippets (snippet library)  
**Formats:** Supports VS Code-style snippets  

### rafamadriz/friendly-snippets
**Purpose:** Library of common code snippets  
**Formats:** Go, Python, Lua, JSON, etc.  
**Usage:** Auto-loaded by LuaSnip  
**Examples:** Function templates, conditional blocks  

### nvim-autopairs (mini.pairs variant)
**Purpose:** Auto-close brackets, quotes, etc.  
**Includes:** Part of nvim-mini/mini.nvim  
**Usage:** Automatic on insert  

### NMAC427/guess-indent.nvim
**Purpose:** Auto-detect indentation (tabs vs spaces, size)  
**Usage:** Automatic on file load  
**Impact:** No manual indent config needed  

---

## Formatting & Linting

### stevearc/conform.nvim
**Purpose:** Code formatter integration  
**Formatters:** Calls external formatters (gofumpt, prettier, etc.)  
**Usage:** `:Conform` command or auto on save  
**For Go:** Works with gopls gofumpt setting  
**Status:** Replaces null-ls  

### nvim-lint
**Purpose:** Linter integration  
**Status:** Configured but can be extended  
**For Go:** Could add golangci-lint, staticcheck  

---

## Language Server Protocol (LSP)

### neovim/nvim-lspconfig
**Purpose:** LSP client configuration  
**Provides:** Pre-made configs for 100+ language servers  
**API:** Uses new `vim.lsp.config` (nvim 0.12+)  
**For Go:** gopls configured in `lua/custom/plugins/gopls.lua`  
**Status:** Core LSP infrastructure  

### mason-org/mason.nvim
**Purpose:** Package manager for LSP servers, formatters, linters  
**Usage:** Install via `:Mason` command  
**Stores:** ~/.local/share/nvim/mason/  
**For Go:** gopls installed manually via `go install`  

### mason-org/mason-lspconfig.nvim
**Purpose:** Bridge between Mason and lspconfig  
**Simplifies:** Automatic setup of Mason-installed servers  
**For custom:** gopls setup in custom/plugins/gopls.lua  

### WhoIsSethDaniel/mason-tool-installer.nvim
**Purpose:** Auto-install formatters/linters via Mason  
**Usage:** Configured in init.lua to auto-install tools  
**Status:** Optional enhancement  

### j-hui/fidget.nvim
**Purpose:** LSP progress notifications  
**Shows:** Spinners while servers initialize  
**Impact:** Visual feedback on LSP activity  

---

## Syntax & Tree-sitter

### nvim-treesitter/nvim-treesitter
**Purpose:** Syntax highlighting, indentation, text objects  
**Parsers:** Need to be installed separately (`:TSInstall`)  
**Current:** Go, Lua, Bash, Python installed  
**CLI:** Requires tree-sitter command (installed via npm)  
**Impact:** Better highlighting and text navigation  

---

## Git Integration

### lewis6991/gitsigns.nvim
**Purpose:** Git change indicators in gutter  
**Shows:** Line additions/modifications/deletions  
**Keybindings:** Stage hunks, toggle blame, etc.  
**Usage:** Automatic for git repos  

---

## Theme & Visual

### folke/tokyonight.nvim
**Purpose:** Color scheme  
**Status:** Default theme in kickstart  
**Variants:** storm, moon, night, day  
**Configure:** Edit `init.lua` to change theme  

### folke/todo-comments.nvim
**Purpose:** Highlight TODO, FIXME, NOTE, HACK comments  
**Highlights:** Different colors for different comment types  
**Usage:** Automatic in comments  
**Search:** `:TodoTelescope` to find all todos  

### nvim-mini/mini.nvim
**Purpose:** Collection of minimal, standalone plugins  
**Includes:**
- `mini.indent` — Indentation guides  
- `mini.icons` — Icon provider for UI  
- `mini.pairs` — Auto-pairing brackets  
- `mini.statusline` — Statusline (custom status bar)  
**Status:** Lightweight alternative to heavier plugins  

---

## Go-Specific Additions

### fredrikaverpil/godoc.nvim
**Purpose:** Go documentation lookup within editor  
**Keybinding:** `<leader>go`  
**Pairs with:** gopls LSP  
**Usage:** Search stdlib and third-party Go packages  
**See:** research/godoc-nvim-integration.md and research/godoc-usage-guide.md  

### Custom: lua/custom/plugins/gopls.lua
**Purpose:** Gopls LSP configuration  
**Settings:** gofumpt formatting, code analyses  
**Features:** Auto-format on save for `.go` files  
**See:** lua/custom/plugins/gopls.lua  

---

## Plugin Architecture Overview

```
init.lua (main config)
├── vim.pack.add {...} (install plugins)
├── vim.pack.add {...} (install plugins)
└── require('custom.plugins') (custom configs)
    ├── lua/custom/plugins/init.lua (auto-loader)
    ├── lua/custom/plugins/gopls.lua (Go LSP setup)
    ├── lua/custom/plugins/godoc.lua (Go docs)
    └── lua/kickstart/plugins/ (plugin-specific setup)
```

---

## Before Adding Research or Plugins

1. **Check this list** — Is it already included?
2. **Check custom/plugins/** — Is it already configured?
3. **Understand dependencies** — Does it need other plugins?
4. **Document in research/** — Add spec and usage guide if novel
5. **Update this document** — Add entry to keep it current

---

## Key Takeaways

- **Package manager:** vim.pack (builtin, not lazy.nvim)
- **LSP infrastructure:** nvim-lspconfig + mason
- **Completion:** blink.cmp + LuaSnip + friendly-snippets
- **Navigation:** Telescope (search/navigation hub)
- **Git:** gitsigns (change indicators)
- **Syntax:** Treesitter (highlighting + text objects)
- **Theme:** TokyoNight
- **Go-specific:** gopls (LSP) + godoc (docs) + conform (formatting)

All plugins prioritize speed and minimalism. Heavy plugins are avoided.
