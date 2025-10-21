return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-tree/nvim-web-devicons',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable('make') == 1
            end,
        },
        'smilovanovic/telescope-search-dir-picker.nvim',
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')
        local fb_actions = telescope.extensions.file_browser.actions

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case', -- case-insensitive unless query has uppercase
                },
                mappings = {
                    i = {
                        ['<C-h>'] = function(prompt_bufnr)
                            local previewer = action_state.get_current_picker(
                                prompt_bufnr
                            ).previewer
                            if previewer and previewer.scroll_fn then
                                previewer:scroll_fn(-1) -- up one line
                            end
                        end,
                        ['<C-l>'] = function(prompt_bufnr)
                            local previewer = action_state.get_current_picker(
                                prompt_bufnr
                            ).previewer
                            if previewer and previewer.scroll_fn then
                                previewer:scroll_fn(1) -- down one line
                            end
                        end,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-q>'] = actions.send_selected_to_qflist
                            + actions.open_qflist,
                    },
                },
            },
            pickers = { oldfiles = { cwd_only = true } },
            extensions = {
                file_browser = {
                    theme = 'ivy',
                    mappings = {
                        ['n'] = {
                            ['N'] = fb_actions.create,
                            ['h'] = fb_actions.goto_parent_dir,
                        },
                    },
                },
            },
        })

        telescope.load_extension('fzf')
        telescope.load_extension('file_browser')
        telescope.load_extension('search_dir_picker')

        vim.keymap.set(
            'n',
            '<leader>?',
            builtin.oldfiles,
            { desc = 'Recently opened files' }
        )
        -- Peek definition using Telescope
        vim.keymap.set('n', 'gp', function()
            require('telescope.builtin').lsp_definitions({ jump_type = 'never' })
        end, { desc = 'Peek definition (Telescope)' })

        vim.keymap.set(
            'n',
            '<leader><space>',
            builtin.buffers,
            { desc = 'Existing buffers' }
        )
        vim.keymap.set('n', '<C-g>', builtin.git_files, { desc = 'Git files' })
        vim.keymap.set(
            'n',
            '<leader>sh',
            builtin.help_tags,
            { desc = 'Search help' }
        )
        vim.keymap.set(
            'n',
            '<leader>fw',
            builtin.grep_string,
            { desc = 'Grep current word' }
        )
        vim.keymap.set(
            'n',
            '<leader>sg',
            builtin.live_grep,
            { desc = 'search grep' }
        )
        vim.keymap.set(
            'n',
            '<leader>sd',
            builtin.diagnostics,
            { desc = '[S]earch [D]iagnostics' }
        )
        vim.keymap.set(
            'n',
            '<leader>fm',
            builtin.man_pages,
            { desc = 'Man pages' }
        )
        vim.keymap.set(
            'n',
            '<leader>fr',
            builtin.lsp_references,
            { desc = 'LSP references' }
        )

        -- Search files
        vim.keymap.set('n', '<leader>sf', function()
            builtin.find_files({
                hidden = true,
                find_command = {
                    'rg',
                    '--files',
                    '--hidden',
                    '--no-ignore-vcs',
                    '--glob',
                    '!**/{.git,node_modules,.next,.vercel,dist,build,.nx,.yarn,coverage}/**',
                },
            })
        end, { desc = '[S]earch [F]iles' })

        -- File browser
        vim.keymap.set('n', '<leader>fe', function()
            telescope.extensions.file_browser.file_browser({
                path = vim.fn.expand('%:p:h'),
                select_buffer = true,
                respect_git_ignore = false,
                hidden = true,
                grouped = true,
                previewer = true,
                initial_mode = 'normal',
            })
        end, { desc = '[S]earch [T]ree' })

        vim.keymap.set(
            'n',
            '<leader>sD',
            require('search_dir_picker').search_dir,
            { desc = 'Pick dir then live_grep' }
        )

        vim.keymap.set('n', '<leader>st', function()
            builtin.colorscheme({ ignore_builtins = true, enable_preview = true })
        end)
    end,
}
