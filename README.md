# Neovim Configuration Documentation

> **Last Updated**: 2025-10-13
> **Neovim Version**: 0.10.4
> **Plugin Manager**: [Lazy.nvim](https://github.com/folke/lazy.nvim)

## Table of Contents
1. [Overview](#overview)
2. [Directory Structure](#directory-structure)
3. [Core Settings](#core-settings)
4. [Keymaps Reference](#keymaps-reference)
5. [LSP Configuration](#lsp-configuration)
6. [Plugins](#plugins)
7. [Language-Specific Setup](#language-specific-setup)
8. [Troubleshooting](#troubleshooting)

---

## Overview

This is a modern Neovim configuration focused on:
- **Language Support**: Rust, TypeScript/JavaScript, Python, C/C++, Lua
- **LSP**: Native LSP with completion, diagnostics, and formatting
- **Code Quality**: Linting (nvim-lint) and formatting (conform.nvim) via Biome
- **Developer Experience**: Fast fuzzy finding, git integration, search & replace

### Philosophy
- Minimal but functional
- Fast startup time
- Native Neovim features where possible
- Clear, documented keybindings

---

## Directory Structure

```
~/.config/nvim/
├── init.lua                           # Entry point
├── lua/dave/
│   ├── core/
│   │   ├── init.lua                   # Core vim settings
│   │   ├── keymaps.lua                # Global keymaps
│   │   └── autocmds.lua               # Autocommands
│   ├── lazy.lua                       # Plugin manager bootstrap
│   └── plugins/
│       ├── lsp.lua                    # LSP configuration
│       ├── cmp.lua                    # Completion
│       ├── telescope.lua              # Fuzzy finder
│       ├── treesitter.lua             # Syntax highlighting
│       ├── conform.lua                # Formatting
│       ├── nvim-lint.lua              # Linting
│       ├── harpoon.lua                # File navigation
│       ├── grug-far.lua               # Search and replace
│       ├── fugitive.lua               # Git commands
│       ├── gitsigns.lua               # Git hunks in gutter
│       ├── comment.lua                # Smart commenting
│       ├── colorscheme.lua            # Theme (Gruvbox)
│       ├── vim-surround.lua           # Surround text objects
│       ├── gx.lua                     # Open URLs
│       ├── which-key.lua              # Keybind helper
│       └── rust/
│           └── main.lua               # Rust-specific setup
├── UPGRADE.md                         # 0.11 upgrade guide
└── CONFIG.md                          # This file
```

---

## Core Settings

### General Settings
**File**: `lua/dave/core/init.lua`

| Setting | Value | Description |
|---------|-------|-------------|
| `mapleader` | `<Space>` | Leader key for custom mappings |
| `guicursor` | `` (empty) | Disable cursor shape changes |
| `termguicolors` | `true` | Enable 24-bit RGB colors |
| `nu` / `relativenumber` | `true` | Line numbers with relative |
| `colorcolumn` | `80` | Visual line length marker |
| `signcolumn` | `yes` | Always show sign column |
| `scrolloff` | `8` | Keep 8 lines visible when scrolling |

### Indentation
| Setting | Value |
|---------|-------|
| `tabstop` | `4` |
| `softtabstop` | `4` |
| `shiftwidth` | `4` |
| `expandtab` | `true` (spaces, not tabs) |
| `autoindent` | `true` |
| `smartindent` | `true` |

### Search
| Setting | Value |
|---------|-------|
| `hlsearch` | `false` (no persistent highlight) |
| `incsearch` | `true` (incremental search) |
| `ignorecase` | `true` |
| `smartcase` | `true` (case-sensitive if uppercase in query) |

### Performance
| Setting | Value |
|---------|-------|
| `updatetime` | `50ms` (faster completion/diagnostics) |
| `timeoutlen` | `300ms` (key sequence timeout) |
| `undofile` | `true` (persistent undo) |

### Autocommands
**File**: `lua/dave/core/autocmds.lua`

- **Highlight on Yank**: Flash yanked text for 40ms
- **.env Files**: Treat as shell scripts for syntax highlighting

---

## Keymaps Reference

> **Legend**: `<leader>` = `<Space>`

### Global Keymaps
**File**: `lua/dave/core/keymaps.lua`

#### Window Management
| Keymap | Mode | Action |
|--------|------|--------|
| `ss` | Normal | Horizontal split |
| `sv` | Normal | Vertical split |
| `sh` | Normal | Move to left split |
| `sk` | Normal | Move to up split |
| `sj` | Normal | Move to down split |
| `sl` | Normal | Move to right split |

#### Editing
| Keymap | Mode | Action |
|--------|------|--------|
| `dw` | Normal | Delete word backwards |
| `<C-a>` | Normal | Select all |
| `J` | Visual | Move line(s) down |
| `K` | Visual | Move line(s) up |
| `<leader>p` | Visual | Paste without yanking |
| `<leader>y` | Normal/Visual | Copy to system clipboard |

#### Navigation
| Keymap | Mode | Action |
|--------|------|--------|
| `<C-d>` | Normal | Half-page down (centered) |
| `<C-u>` | Normal | Half-page up (centered) |
| `n` | Normal | Next search result (centered) |
| `N` | Normal | Previous search result (centered) |
| `<leader>j` | Normal | Next quickfix item |
| `<leader>k` | Normal | Previous quickfix item |

### Telescope (Fuzzy Finder)
**File**: `lua/dave/plugins/telescope.lua`

| Keymap | Action |
|--------|--------|
| `<leader>sf` | Search files (including hidden) |
| `<leader>sg` | Live grep (search content) |
| `<leader>fgc` | Live grep (case-sensitive) |
| `<leader>fgd` | Live grep in custom directory |
| `<leader>sw` | Search current word under cursor |
| `<leader>?` | Recently opened files |
| `<leader><space>` | Open buffers |
| `<leader>fb` | File browser (tree view) |
| `<leader>sh` | Search help tags |
| `<leader>sd` | Search diagnostics |
| `<C-g>` | Git files |

**Telescope Insert Mode:**
- `<C-k>` - Previous result
- `<C-j>` - Next result
- `<C-q>` - Send to quickfix list

### Harpoon (Quick File Navigation)
**File**: `lua/dave/plugins/harpoon.lua`

| Keymap | Action |
|--------|--------|
| `<leader>a` | Add current file to Harpoon |
| `<C-e>` | Toggle Harpoon menu |
| `<C-h>` | Jump to Harpoon file 1 |
| `<C-j>` | Jump to Harpoon file 2 |
| `<C-k>` | Jump to Harpoon file 3 |
| `<C-l>` | Jump to Harpoon file 4 |
| `<C-S-P>` | Previous Harpoon file |
| `<C-S-N>` | Next Harpoon file |

### LSP (Language Server Protocol)
**File**: `lua/dave/plugins/lsp.lua`

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gr` | Show references |
| `gI` | Go to implementation |
| `<leader>D` | Go to type definition |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>e` | Open diagnostic float |
| `<C-p>` | Previous diagnostic |
| `<C-n>` | Next diagnostic |
| `<leader>q` | Open diagnostic list |
| `<leader>rs` | Restart LSP server |

### Git Integration

#### Fugitive
**File**: `lua/dave/plugins/fugitive.lua`

| Keymap | Action |
|--------|--------|
| `<leader>gs` | Git stash |
| `<leader>gp` | Git stash pop |
| `<leader>gc` | Git commit |
| `<leader>ga` | Git add current file |
| `<leader>gb` | Git blame |
| `<leader>gd` | Git diff |
| `<leader>gv` | Git diff split |
| `<leader>gl` | Git log |
| `<leader>gr` | Git rebase interactive |

#### Gitsigns (Hunk Navigation)
**File**: `lua/dave/plugins/gitsigns.lua`

| Keymap | Action |
|--------|--------|
| `<leader>hh` | Previous hunk |
| `<leader>hl` | Next hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hu` | Undo stage hunk |
| `<leader>hr` | Reset hunk |

### Search and Replace (Grug-far)
**File**: `lua/dave/plugins/grug-far.lua`

| Keymap | Mode | Action |
|--------|------|--------|
| `<leader>sr` | Normal | Open search and replace UI |
| `<leader>sr` | Visual | Search and replace selection |

**Note**: Uses ripgrep for fast searching. Preview changes before applying.

### Code Quality

#### Formatting (Conform)
**File**: `lua/dave/plugins/conform.lua`

| Keymap | Action |
|--------|--------|
| `<leader>lf` | Format current file |

**Auto-format on save**: Enabled via `BufWritePre` autocmd

#### Linting (nvim-lint)
**File**: `lua/dave/plugins/nvim-lint.lua`

| Keymap | Action |
|--------|--------|
| `<leader>ll` | Lint current file |

**Auto-lint on save**: Enabled via `BufWritePre` autocmd

### Tree-sitter Text Objects
**File**: `lua/dave/plugins/treesitter.lua`

#### Select
| Keymap | Mode | Action |
|--------|------|--------|
| `af` | Visual | Select around function |
| `if` | Visual | Select inside function |
| `ac` | Visual | Select around class |
| `ic` | Visual | Select inside class |

#### Navigate
| Keymap | Action |
|--------|--------|
| `]f` | Next function start |
| `]F` | Next function end |
| `[f` | Previous function start |
| `[F` | Previous function end |
| `]c` | Next class start |
| `]C` | Next class end |
| `[c` | Previous class start |
| `[C` | Previous class end |

### Comments
**File**: `lua/dave/plugins/comment.lua`

Default Comment.nvim keybindings (context-aware for TSX/JSX):
- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gc` (visual) - Toggle comment for selection

---

## LSP Configuration

### Installed Language Servers
**File**: `lua/dave/plugins/lsp.lua`

Via Mason and nvim-lspconfig:
- **Lua**: `lua_ls` (with vim globals)
- **TypeScript/JavaScript**: `biome` (lsp-proxy mode)
- **Python**: `pyright`
- **C/C++**: `clangd`
- **Rust**: `rust_analyzer` (via rustaceanvim)
- **CSS/Tailwind**: `tailwindcss`

### Capabilities
LSP clients are configured with `cmp_nvim_lsp.default_capabilities()` for:
- Enhanced completion support
- Snippet support
- Resolve support

### Important Note
`cmp-nvim-lsp` is pinned to commit `39e2eda` for Neovim 0.10.4 compatibility.
**Remove this pin when upgrading to Neovim 0.11+**

---

## Plugins

### Core Plugins

#### 1. Lazy.nvim (Plugin Manager)
- **Repo**: `folke/lazy.nvim`
- **Lazy-loads** plugins for faster startup
- **Commands**: `:Lazy sync`, `:Lazy update`, `:Lazy clean`

#### 2. Telescope (Fuzzy Finder)
- **Repo**: `nvim-telescope/telescope.nvim`
- **Extensions**:
  - `telescope-fzf-native` (fast sorting)
  - `telescope-file-browser` (tree view)
- **Config**: Case-insensitive search, custom keymaps

#### 3. nvim-cmp (Completion)
- **Repo**: `hrsh7th/nvim-cmp`
- **Sources**:
  - `nvim_lsp` (LSP completion)
  - `luasnip` (snippets)
  - `buffer` (buffer words)
- **Keybinds**:
  - `<C-k>` / `<C-j>` - Navigate suggestions
  - `<C-Space>` - Trigger completion
  - `<C-y>` - Confirm
  - `<C-q>` - Abort

#### 4. Treesitter (Syntax Highlighting)
- **Repo**: `nvim-treesitter/nvim-treesitter`
- **Languages**: C, C++, Lua, Python, Rust, JS, TS, Vim, JSDoc
- **Features**:
  - Syntax highlighting
  - Text objects (functions, classes)
  - Smart navigation
- **Auto-installs** parsers on file open

#### 5. LSP Config
- **Repo**: `neovim/nvim-lspconfig`
- **Version**: Pinned to `1.8.0`
- **Mason Integration**: Auto-installs LSP servers
- **See**: [LSP Configuration](#lsp-configuration)

#### 6. Conform.nvim (Formatting)
- **Repo**: `stevearc/conform.nvim`
- **Formatters**:
  - **JS/TS/JSON/CSS**: `biome-check`
  - **Lua**: `stylua`
  - **TOML**: `taplo`
  - **HTML**: `htmlbeautifier`
- **Auto-formats** on save
- **LSP Fallback**: If no formatter configured

#### 7. nvim-lint (Linting)
- **Repo**: `mfussenegger/nvim-lint`
- **Linters**:
  - **JS/TS/TSX/JSX**: `biomejs`
- **Auto-lints** on save

### Workflow Plugins

#### 8. Harpoon 2
- **Repo**: `ThePrimeagen/harpoon` (branch: harpoon2)
- **Purpose**: Quick navigation between frequently used files
- **Usage**: Mark files with `<leader>a`, jump with `<C-h/j/k/l>`

#### 9. Fugitive (Git Commands)
- **Repo**: `tpope/vim-fugitive`
- **Purpose**: Git workflow inside Neovim
- **Common Commands**: `:G status`, `:G commit`, `:G push`

#### 10. Gitsigns (Git Decorations)
- **Repo**: `lewis6991/gitsigns.nvim`
- **Purpose**: Show git changes in gutter
- **Features**: Hunk navigation, staging, preview

#### 11. Comment.nvim
- **Repo**: `numToStr/Comment.nvim`
- **Integration**: `nvim-ts-context-commentstring` for TSX/JSX
- **Smart** comment/uncomment based on file type

#### 12. vim-surround
- **Repo**: `tpope/vim-surround`
- **Usage**:
  - `ysiw"` - Surround word with "
  - `cs"'` - Change " to '
  - `ds"` - Delete surrounding "

#### 13. grug-far (Search and Replace)
- **Repo**: `MagicDuck/grug-far.nvim`
- **Version**: Pinned to `1.6.3` (Neovim 0.10.4 compatible)
- **Engine**: ripgrep (fast search across files)
- **Features**:
  - Interactive UI for search and replace
  - Preview changes before applying
  - Regex support
  - Works on entire project or selection
- **Note**: Remove version pin when upgrading to Neovim 0.11+

### UI/Theme

#### 14. Gruvbox (Colorscheme)
- **Repo**: `morhetz/gruvbox`
- **Config**: Transparent background enabled
- **Applied**: On VimEnter

#### 15. which-key (Keybind Helper)
- **Repo**: `folke/which-key.nvim`
- **Shows** available keybindings after leader key

---

## Language-Specific Setup

### Rust
**File**: `lua/dave/plugins/rust/main.lua`

#### Plugins
1. **rustaceanvim** (`mrcjkb/rustaceanvim`)
   - Modern Rust LSP integration
   - Replaces rust-tools.nvim
   - Auto-configures rust-analyzer

2. **crates.nvim** (`saecki/crates.nvim`)
   - Cargo.toml dependency management
   - Show latest versions inline
   - Update dependencies easily

3. **rust.vim** (`rust-lang/rust.vim`)
   - Auto-format on save with rustfmt

#### Rust Capabilities
- Proper LSP capabilities configured for completion
- Matches main LSP config setup

### TypeScript/JavaScript
- **LSP**: Biome (lsp-proxy)
- **Formatting**: Biome
- **Linting**: Biome
- **Note**: Prettier config commented out but available

### Python
- **LSP**: Pyright
- **Formatting**: LSP fallback

### Lua
- **LSP**: lua_ls
- **Config**: `vim` global recognized
- **Formatting**: stylua

### C/C++
- **LSP**: clangd
- **Formatting**: LSP fallback

---

## Troubleshooting

### Common Issues

#### 1. LSP Not Starting
```vim
:LspInfo  " Check LSP status
:Mason    " Verify servers installed
:checkhealth  " Run health checks
```

#### 2. Completion Not Working
- Ensure `cmp-nvim-lsp` is pinned to correct commit
- Verify LSP client has capabilities configured
- Check `:LspInfo` shows attached client

#### 3. Formatting Not Working
```vim
:ConformInfo  " Check formatter status
:Mason  " Verify formatters installed
```
- Ensure `biome` is installed globally or via Mason
- Check `conform.formatters_by_ft` matches your filetype

#### 4. Linting Not Working
```vim
:lua print(vim.inspect(require('lint').linters_by_ft))  " Check config
```
- Ensure `biomejs` is installed
- Check `nvim-lint` is configured for your filetype

#### 5. Telescope Slow
- Ensure `telescope-fzf-native` compiled: `cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim && make`
- Check `:checkhealth telescope`

#### 6. Tree-sitter Highlighting Issues
```vim
:TSInstall <language>  " Install parser
:TSUpdate  " Update all parsers
:checkhealth nvim-treesitter
```

#### 7. Rust Analyzer Not Working
- Ensure `rustup` is installed
- Verify `rust-analyzer` in PATH
- Check rustaceanvim loaded: `:Lazy load rustaceanvim`

#### 8. Grug-far Not Working
- Ensure `ripgrep` is installed: `brew install ripgrep`
- Check version: Pinned to `1.6.3` for Neovim 0.10.4
- Try `:lua print(vim.inspect(require('grug-far')))` to verify it's loaded

### Health Checks
Run comprehensive health checks:
```vim
:checkhealth
:checkhealth lsp
:checkhealth nvim-treesitter
:checkhealth telescope
```

### Plugin Management
```vim
:Lazy sync      " Update all plugins
:Lazy clean     " Remove unused plugins
:Lazy profile   " Check startup time
:Lazy restore   " Restore from lockfile
```

### Reset Steps
If things break:
1. Backup: `cp -r ~/.config/nvim ~/.config/nvim.backup`
2. Clean plugins: `rm -rf ~/.local/share/nvim`
3. Restart Neovim: Lazy will reinstall everything
4. Run `:Mason` and install servers
5. Run `:checkhealth`

---

## Performance Tips

### Startup Time
Current config is optimized for fast startup via lazy-loading:
- Plugins load on specific filetypes
- LSP loads on `LspAttach` event
- Telescope loads on first keymap trigger

Check startup time:
```bash
nvim --startuptime startup.log
```

### Large Files
- Tree-sitter highlights up to 2000 lines by default
- Consider `:syntax off` for very large files
- Use `:LspStop` if LSP is slow

### Memory Usage
- Keep plugin count reasonable
- Uninstall unused language servers via Mason
- Clear undo files: `rm -rf ~/.config/nvim/undo/*`

---

## Maintenance Checklist

### Weekly
- [ ] Update plugins: `:Lazy sync`
- [ ] Update LSP servers: `:Mason update`
- [ ] Check for breaking changes in plugin READMEs

### Monthly
- [ ] Review `:checkhealth` output
- [ ] Clean up unused plugins: `:Lazy clean`
- [ ] Review and optimize keybindings
- [ ] Backup config: `git commit -am "Monthly backup"`

### Before Major Changes
- [ ] Backup: `cp -r ~/.config/nvim ~/.config/nvim.backup`
- [ ] Document current state
- [ ] Test in isolated environment if possible

---

## Additional Resources

### Learning Resources
- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Guide](https://github.com/folke/lazy.nvim)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)
- [Telescope Documentation](https://github.com/nvim-telescope/telescope.nvim)

### Community
- [r/neovim](https://reddit.com/r/neovim)
- [Neovim Discourse](https://neovim.discourse.group/)
- [#neovim on Libera.Chat IRC](https://web.libera.chat/#neovim)

### Related Files
- [UPGRADE.md](./UPGRADE.md) - Guide for upgrading to Neovim 0.11

---

## Notes

- This config prioritizes **stability** over bleeding-edge features
- **Biome** is the primary tool for JS/TS (linting, formatting, LSP)
- **Leader key is Space** - all custom bindings use this
- **Transparent background** enabled for terminal integration
- **Auto-format and auto-lint** on save for most languages
- **Git integration** is comprehensive (fugitive + gitsigns)
- **Search & replace** via grug-far for project-wide refactoring
- **Version pins** for Neovim 0.10.4 compatibility (cmp-nvim-lsp, grug-far)

