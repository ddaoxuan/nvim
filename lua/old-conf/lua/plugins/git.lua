return {

  'dinhhuy258/git.nvim', -- For git blame & browse
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive', -- For git conflicts and staging
  },
  config = function()
    local git = require 'git'
    local gitsigns = require 'gitsigns'

    git.setup {
      keymaps = {
        -- Open blame window
        blame = '<leader>gb',
        -- Open file/folder in git repository
        browse = '<leader>go',
      },
    }

    gitsigns.setup {}
  end,
}
