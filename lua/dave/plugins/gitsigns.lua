return {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        -- See `:help gitsigns.txt`
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
            local gs = require('gitsigns')
            vim.keymap.set(
                'n',
                '<leader>hh',
                gs.prev_hunk,
                { buffer = bufnr, desc = 'previous hunk' }
            )
            vim.keymap.set(
                'n',
                '<leader>hl',
                gs.next_hunk,
                { buffer = bufnr, desc = 'next hunk' }
            )
            vim.keymap.set(
                'n',
                '<leader>hp',
                gs.preview_hunk,
                { buffer = bufnr, desc = 'preview hunk' }
            )
            vim.keymap.set(
                'n',
                '<leader>hs',
                gs.stage_hunk,
                { buffer = bufnr, desc = 'stage hunk' }
            )

            vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, {
                buffer = bufnr,
                desc = 'undo stage hunk',
            })

            vim.keymap.set('n', '<leader>hr', gs.reset_hunk, {
                buffer = bufnr,
                desc = 'reset hunk',
            })
        end,
    },
}
