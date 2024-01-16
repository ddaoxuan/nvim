return {
    -- "gcc/gbc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true, -- runs require('Comment').setup()
}
