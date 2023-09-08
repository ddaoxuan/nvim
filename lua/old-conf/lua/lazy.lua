--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  { import = 'plugins' },
  { import = 'plugins.lsp' },

  { 'terrortylor/nvim-comment', event = { 'InsertEnter' } }, -- Toggle comments (Needs revisting as it only supports 1 language now)
  { 'windwp/nvim-autopairs', event = { 'InsertEnter' } },
  { 'windwp/nvim-ts-autotag', event = { 'InsertEnter' } },
  'nvim-lua/plenary.nvim', -- Common utilities
  { 'mg979/vim-visual-multi', event = { 'InsertEnter' } }, -- Multiline insertion
  'tpope/vim-unimpaired', -- Merge conflicts helper
  { 'tpope/vim-surround', event = 'InsertEnter' }, -- Delete / add / change parentheses
}

--   -- LSP + tree sitter to provide TS/eslint support
--     'nvim-treesitter/nvim-treesitter',
--     run = ':TSUpdate'
