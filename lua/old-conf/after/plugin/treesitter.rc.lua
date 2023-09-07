local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    'tsx',
    'lua',
    'json',
    'css'
  },
  autotag = {
    enable = true,
  },
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      [']m'] = '@function.outer',
    },
    goto_next_end = {
      [']M'] = '@function.outer',
    }
  }
}
