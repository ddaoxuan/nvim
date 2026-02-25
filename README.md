# Neovim Config

Current as of 2026-02-25. This README reflects the active Lua config in this repo.

## Quick Start

```bash
git clone <this-repo> ~/.config/nvim
nvim
```

On first start, `lazy.nvim` bootstraps automatically.

Useful commands:
- `:Lazy sync` / `:Lazy update`
- `:Mason`
- `:checkhealth`

`lazy.nvim` settings:
- auto-check updates enabled (`checker.enabled = true`)
- checker notifications disabled
- change-detection notifications disabled

## Layout

```text
~/.config/nvim/
├── init.lua
├── lazy-lock.json
├── lua/dave/
│   ├── core/
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   └── autocmds.lua
│   ├── lazy.lua
│   └── plugins/
│       ├── cmp.lua
│       ├── colorscheme.lua
│       ├── comment.lua
│       ├── conform.lua
│       ├── copilot.lua
│       ├── fugitive.lua
│       ├── gitsigns.lua
│       ├── grug-far.lua
│       ├── gx.lua
│       ├── harpoon.lua
│       ├── lsp.lua
│       ├── nvim-lint.lua
│       ├── rust/main.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       ├── vim-surround.lua
│       ├── which-key.lua
│       └── zen.lua
└── pack/github/start/copilot.vim
```

## Core Editor Settings

Leader keys:
- `mapleader = ' '`
- `maplocalleader = ' '`

Global options:

| Option | Value |
|---|---|
| `guicursor` | `''` |
| `termguicolors` | `true` |
| `autoindent` | `true` |
| `softtabstop` / `tabstop` / `shiftwidth` | `4` |
| `expandtab` | `true` |
| `ai` / `si` / `smarttab` | `true` |
| `breakindent` | `true` |
| `ignorecase` / `smartcase` | `true` |
| `updatetime` | `50` |
| `timeout` | `true` |
| `timeoutlen` | `300` in core, overridden to `100` by `which-key` |
| `colorcolumn` | `'80'` |
| `signcolumn` | `'yes'` |
| `scrolloff` | `8` |
| `undofile` | `true` |
| `undodir` | `stdpath('config') .. '/undo'` |
| `backupskip` | `'/tmp/*,/private/tmp/*'` |
| `number` / `relativenumber` | `true` |
| `hlsearch` | `false` |
| `incsearch` | `true` |
| `shell` | `'zsh'` |
| `netrw_browse_split` | `0` |
| `netrw_banner` | `0` |
| `netrw_winsize` | `25` |
| `netrw_nogx` | `1` (set by `gx.nvim`) |
| `editorconfig` | `true` |

Autocmds:
- `TextYankPost`: highlight yank (`IncSearch`, `40ms`).
- `BufReadPost` on `.env*`: set `filetype=sh`.
- `BufWritePre`: format with `conform` (`lsp_fallback=true`, `timeout=500`).
- `BufWritePre`: run `nvim-lint`.
- `LspAttach`: register LSP-local keymaps.

## Tooling Settings

### LSP

Managed by `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig`.
`mason-lspconfig` is set to auto-install all configured servers.

Configured servers:
- `rust_analyzer` (installed, but standard setup is skipped so Rust is handled by `rustaceanvim`)
- `tailwindcss`
- `ruff`
- `clangd`
- `pyright`
- `lua_ls` with `Lua.diagnostics.globals = { 'vim' }`

Mason UI icons:
- installed: `✓`
- pending: `➜`
- uninstalled: `✗`

Non-Rust servers are configured with `cmp_nvim_lsp.default_capabilities(...)`.

### Completion (`nvim-cmp`)

Mappings:
- `<C-k>` previous item
- `<C-j>` next item
- `<C-Space>` trigger completion
- `<C-q>` abort
- `<C-y>` confirm (`select = true`)

Configured sources:
- `nvim_lsp`
- `luasnip`

Installed completion dependencies also include:
- `cmp-buffer`, `cmp-path`, `cmp-cmdline`, `cmp_luasnip`, `LuaSnip`
- `cmp-nvim-lsp` pinned to commit `39e2eda76828d88b773cc27a3f61d2ad782c922d`

### Formatting (`conform.nvim`)

Format on save is enabled.

| Filetype(s) | Formatter |
|---|---|
| `javascript`, `typescript`, `javascriptreact`, `typescriptreact`, `json`, `svelte`, `graphql`, `css`, `scss`, `markdown` | `biome-check` |
| `hcl` | `packer_fmt` |
| `terraform`, `tf`, `terraform-vars` | `terraform_fmt` |
| `toml` | `taplo` |
| `html` | `htmlbeautifier` |
| `lua` | `stylua` |

Manual format keymap: `<leader>lf`.

### Linting (`nvim-lint`)

Lint on save is enabled.

| Filetype(s) | Linter |
|---|---|
| `javascript`, `typescript`, `javascriptreact`, `typescriptreact`, `svelte` | `eslint_d` |

Manual lint keymap: `<leader>ll`.

### Treesitter

Parsers ensured:
- `c`, `cpp`, `lua`, `python`, `rust`, `javascript`, `typescript`, `vim`, `vimdoc`, `jsdoc`

Enabled:
- highlight
- textobjects select + move
- parser auto-install (`auto_install = true`)

Textobject keymaps:
- select: `af`, `if`, `ac`, `ic`, `aa`, `ia`
- move: `)`, `}`, `(`, `{`, `ga`, `gA`

## Plugin Settings (Active)

### Search / Navigation
- `nvim-lua/plenary.nvim`
- `nvim-telescope/telescope.nvim`
  - `rg --smart-case` defaults
  - `oldfiles` limited to current cwd
  - file browser extension: `theme = 'ivy'`
  - loads extensions: `fzf`, `file_browser`, `search_dir_picker`
  - `<leader>sf` excludes: `.git`, `node_modules`, `.next`, `dist`, `build`, `.nx`, `.yarn`, `coverage`
  - `<leader>sD` directory picker excludes: `node_modules`, `.next`, `dist`, `.vercel`, `build`, `.nx`, `.yarn`, `coverage`
- `nvim-telescope/telescope-file-browser.nvim`
- `nvim-telescope/telescope-fzf-native.nvim` (builds with `make` when available)
- `smilovanovic/telescope-search-dir-picker.nvim`
- `ThePrimeagen/harpoon` (branch `harpoon2`)
- `MagicDuck/grug-far.nvim` version `1.6.3`
- `chrishrb/gx.nvim`
  - opens with macOS `open --background`
  - search fallback engine: `google`
  - handlers enabled: `plugin`, `github`, `brewfile`, `package_json`, `search`, `go`, custom Rust crate handler for `Cargo.toml`

### LSP / Coding
- `neovim/nvim-lspconfig` version `1.8.0`
- `williamboman/mason.nvim`
- `williamboman/mason-lspconfig.nvim` version `1.32.0`
- `hrsh7th/nvim-cmp`
- `stevearc/conform.nvim`
- `mfussenegger/nvim-lint`
- `nvim-treesitter/nvim-treesitter`
- `nvim-treesitter/nvim-treesitter-textobjects`
- `numToStr/Comment.nvim` + `JoosepAlviste/nvim-ts-context-commentstring`
- `tpope/vim-surround`
- `nvim-tree/nvim-web-devicons`

### Git
- `tpope/vim-fugitive`
- `lewis6991/gitsigns.nvim`

### UI / Theme / Focus
- `folke/tokyonight.nvim` (configured colorscheme is `rose-pine-moon`)
- theme dependencies installed: `rose-pine/neovim`, `morhetz/gruvbox`, `sainnhe/everforest`, `rebelot/kanagawa.nvim`, `bettervim/yugen.nvim`, `datsfilipe/vesper.nvim`
- `folke/which-key.nvim`
- `folke/zen-mode.nvim`

### Rust
- `mrcjkb/rustaceanvim` (`version = '^5'`, lazy on `ft=rust`)
- `rust-lang/rust.vim` (`rustfmt_autosave = true`)
- `saecki/crates.nvim` (enabled on `ft=toml`, integrates with cmp)

`rustaceanvim` expects CodeLLDB at:
- `stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb'`
- `stdpath('data') .. '/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib'`

If CodeLLDB is missing, Rust DAP setup is skipped with a warning.

### Copilot
- `github/copilot.vim` (plugin spec sets `version = '1.54.0'`)
- a local package copy also exists at `pack/github/start/copilot.vim`

## Keymaps

`<leader>` is `<Space>`.

### Core

| Mode | Key | Action |
|---|---|---|
| `n,v` | `<Space>` | No-op (reserve leader) |
| `n` | `dw` | Delete word backwards |
| `n` | `ss` | Horizontal split |
| `n` | `sv` | Vertical split |
| `n` | `<C-a>` | Select all |
| `n` | `sh` / `sk` / `sj` / `sl` | Move between windows |
| `n` | `<C-d>` / `<C-u>` | Half-page down/up, centered |
| `n` | `n` / `N` | Next/prev search result, centered |
| `n` | `<C-j>` / `<C-k>` | Quickfix next/prev |
| `n` | `<leader>oq` | Toggle quickfix window |
| `n` | `<C-h>` / `<C-l>` | Location list next/prev |
| `n` | `<leader>ol` | Toggle location list |
| `v` | `J` / `K` | Move selection down/up |
| `x` | `<leader>p` | Paste without replacing unnamed register |
| `n,v` | `<leader>y` | Yank to system clipboard |

### LSP (buffer-local on attach)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | References |
| `gI` | Go to implementation |
| `<leader>D` | Type definition |
| `K` | Hover |
| `<leader>rn` | Rename |
| `<C-p>` / `<C-n>` | Diagnostic prev/next |
| `<leader>e` | Diagnostic float |
| `<leader>q` | Diagnostics to location list |
| `<leader>rs` | `:LspRestart` |

### Telescope

| Key | Action |
|---|---|
| `<leader>?` | Recent files |
| `gp` | Peek definition (no jump) |
| `<leader><space>` | Buffers |
| `<C-g>` | Git files |
| `<leader>sh` | Help tags |
| `<leader>fw` | Grep current word |
| `<leader>sg` | Live grep (includes hidden, excludes `.git`) |
| `<leader>sd` | Diagnostics picker |
| `<leader>fm` | Man pages |
| `<leader>fr` | LSP references picker |
| `<leader>sf` | Find files (hidden, custom excludes) |
| `<leader>fe` | File browser at current file dir |
| `<leader>sD` | Pick a directory, then live grep |
| `<leader>st` | Colorscheme picker |

Telescope prompt mappings:
- insert + normal: `<C-a>` toggle all selections
- insert: `<C-k>`/`<C-j>` move selection
- insert: `<C-h>`/`<C-l>` scroll preview up/down one line
- insert: `<C-q>` send selected items to quickfix and open quickfix

File browser extension mappings (`normal` mode):
- `N`: create
- `h`: parent directory

File browser launch options on `<leader>fe`:
- `path = current file directory`
- `select_buffer = true`
- `respect_git_ignore = false`
- `no_ignore = true`
- `no_ignore_parent = true`
- `hidden = true`
- `grouped = true`
- `previewer = true`
- `initial_mode = 'normal'`

### Git

| Key | Action |
|---|---|
| `<leader>gs` | `:G stash` |
| `<leader>gp` | `:G stash pop` |
| `<leader>gc` | `:G commit` |
| `<leader>ga` | `:Gwrite` |
| `<leader>gb` | `:G blame` |
| `<leader>gd` | `:Gdiff` |
| `<leader>gv` | `:Gvdiffsplit!` |
| `<leader>gl` | `:G log` |
| `<leader>gr` | `:G rebase -i` |
| `<leader>hh` | Previous hunk |
| `<leader>hl` | Next hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hu` | Undo stage hunk |
| `<leader>hr` | Reset hunk |

Gitsigns symbols:
- add: `+`
- change: `~`
- delete: `_`
- topdelete: `‾`
- changedelete: `~`

### Search / Replace / Utility

| Mode | Key | Action |
|---|---|---|
| `n` | `<leader>lf` | Format current buffer (`conform`) |
| `n` | `<leader>ll` | Lint current buffer (`nvim-lint`) |
| `n` | `<leader>sr` | Open grug-far |
| `n` | `<leader>sw` | Grug-far prefilled with current word |
| `v` | `<leader>sr` | Grug-far with visual selection |
| `n,x` | `gx` | Open link / handler target |

### Harpoon

| Key | Action |
|---|---|
| `<M-a>` | Add file |
| `<M-e>` | Toggle menu |
| `<M-1>` / `<M-2>` / `<M-3>` / `<M-4>` | Jump to slot 1-4 |

### Zen Mode

| Key | Action |
|---|---|
| `<leader>gz` | Zen width 110, `wrap=false`, `number=true`, `relativenumber=true` |
| `<leader>gZ` | Zen width 80, `wrap=false`, `number=false`, `relativenumber=false`, `colorcolumn=0` |

## Notes

- Plugin revisions are locked in `lazy-lock.json`.
- This setup expects external tools such as `git`, `rg`, `fd`, `make` (for `telescope-fzf-native`), `eslint_d`, `biome`, `stylua`, `taplo`, `terraform_fmt`, `packer_fmt`, and language servers used by Mason.
