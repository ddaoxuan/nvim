-- [[ Configure nvim-cmp ]]
-- See `:help cmp`

return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter' },
  dependencies = {
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'L3MON4D3/LuaSnip', -- Snippet engine
    'saadparwaiz1/cmp_luasnip', -- Completion source for snippets
    'rafamadriz/friendly-snippets', -- Adds a number of user-friendly snippets
    'hrsh7th/cmp-nvim-lsp', -- Adds LSP completion capabilities
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load() -- load vs-code like snippets from plugins

    cmp.setup {
      completion = {
        completeopt = 'menu, menuone, preview, noselect',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- prev suggestion
        ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {}, -- Show completion window
        ['<C-e>'] = cmp.mapping.abort(), -- close completion window
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      },
      -- sources for completion
      sources = {
        { name = 'nvim_lsp' }, -- lsp
        { name = 'buffer' }, -- text within current buffer
        { name = 'luasnip' }, -- snippets
        { name = 'path' }, -- file system paths
      },
    }
  end,
}
