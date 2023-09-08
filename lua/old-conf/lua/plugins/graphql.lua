return {
  'jparise/vim-graphql',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('vim-graphql').setup {}
  end,
}
