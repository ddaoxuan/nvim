return {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
        local tsx_comment =
            require('ts_context_commentstring.integrations.comment_nvim')
        require('Comment').setup({
            pre_hook = tsx_comment.create_pre_hook(),
        })
    end,
}
