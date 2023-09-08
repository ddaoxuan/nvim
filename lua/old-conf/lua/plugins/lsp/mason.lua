return {

  'williamboman/mason.nvim', -- Portable package manager for Neovim
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },

  config = function()
    require('mason').setup {}
    require('mason-lspconfig').setup {
      ensure_installed = { 'tailwindcss', 'tsserver', 'sumneko_lua', 'clangd' },
    }
  end,
}
