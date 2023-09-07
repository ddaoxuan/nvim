local status, packer = pcall(require, 'packer')

if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Theme
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use 'onsails/lspkind-nvim'         -- vscode-like pictograms
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'hoob3rt/lualine.nvim'         -- Status line

  -- Preview colours as coding
  use 'norcalli/nvim-colorizer.lua'

  -- [Actions]
  use 'L3MON4D3/LuaSnip'     -- Snippets
  use 'hrsh7th/cmp-buffer'   -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built in LSP
  use 'hrsh7th/nvim-cmp'     -- Auto completion

  -- LSP + tree sitter to provide TS/eslint support
  use 'neovim/nvim-lspconfig' -- LSP
  use 'glepnir/lspsaga.nvim'  -- LSP UIs
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- Code formatting
  use 'jose-elias-alvarez/null-ls.nvim' -- use neovim as a language server to inject lsp diagnostics, code actions, and more
  use 'williamboman/mason.nvim'         -- Portable package manager for Neovim
  use 'williamboman/mason-lspconfig.nvim'

  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for neovim's built-in LSP client

  --  Auto pairs and auto tags
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'ThePrimeagen/harpoon'

  -- Fuzzy finder
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'akinsho/nvim-bufferline.lua'

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim'      -- For git blame & browse
  use 'tpope/vim-fugitive'       -- For git conflicts and staging

  use 'mg979/vim-visual-multi'   -- Multiline insertion
  use 'tpope/vim-unimpaired'     -- Merge conflicts helper
  use 'tpope/vim-surround'       -- Delete / add / change parentheses
  use 'terrortylor/nvim-comment' -- Toggle comments (Needs revisting as it only supports 1 language now)
  use 'jparise/vim-graphql'
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'prisma/vim-prisma'
end)
