return {
    'glepnir/lspsaga.nvim',
    config = function()
        local saga = require('lspsaga')
        local opts = { noremap = true, silent = true }

        saga.setup({
            server_filetype_map = {},
        })

        vim.keymap.set(
            'n',
            '<C-p>',
            '<Cmd>Lspsaga diagnostic_jump_prev<cr>',
            opts
        )
        vim.keymap.set(
            'n',
            '<C-n>',
            '<Cmd>Lspsaga diagnostic_jump_next<cr>',
            opts
        )
        vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<cr>', opts)
    end,
}
