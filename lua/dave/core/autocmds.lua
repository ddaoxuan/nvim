local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', { clear = true })

-- highlight on yank
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- treat .env files as sh
autocmd('BufReadPost', {
    pattern = '.env*',
    command = 'set filetype=sh',
})
