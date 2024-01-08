return {
    'glepnir/lspsaga.nvim',
    config = function()
        local saga = require('lspsaga')
        local opts = { noremap = true, silent = true }

        saga.setup({
            server_filetype_map = {},
        })

        vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<cr>', opts)
    end,
}
