-- [[ Configure Telescope - Fuzzy Finder ]]
-- See `:help telescope` and `:help telescope.setup()`
return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'BurntSushi/ripgrep',
        'nvim-lua/plenary.nvim', -- lua functions that telescope needs
        'nvim-telescope/telescope-file-browser.nvim', -- tree structure plugin
        'nvim-tree/nvim-web-devicons',
        {
            -- improve telescope sorting perf
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable('make') == 1
            end,
        },
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local fb_actions = telescope.extensions.file_browser.actions

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = actions.move_selection_previous, -- move to prev result
                        ['<C-j>'] = actions.move_selection_next, -- move to next resultj
                        ['<C-q>'] = actions.send_selected_to_qflist
                            + actions.open_qflist, -- send to qf list and open
                    },
                },
            },
            pickers = {
                oldfiles = {
                    cwd_only = true,
                },
            },
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

        telescope.load_extension('fzf') -- Enable telescope fzf native, if installed
        telescope.load_extension('file_browser')

        -- [[ Telescope keymaps ]]
        -- See `:help telescope.builtin`

        -- builtins
        vim.keymap.set(
            'n',
            '<leader>?',
            builtin.oldfiles,
            { desc = 'Recently opened files' }
        )
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
            '<leader>sw',
            builtin.grep_string,
            { desc = '[S]earch current [W]ord' }
        )
        vim.keymap.set('n', '<leader>fgc', function()
            builtin.live_grep({
                additional_args = function()
                    return { '--case-sensitive' }
                end,
            })
        end, { desc = 'search grep case sensitive' })
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
        vim.keymap.set('n', '<leader>fm', builtin.man_pages, {
            desc = 'Lists manpage entries, opens them in a help window on <cr>',
        })

        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {
            desc = 'Lists LSP references for word under the cursor',
        })

        -- Extensions
        vim.keymap.set('n', '<leader>sf', function()
            require('telescope.builtin').find_files({
                hidden = true, -- show dotfiles
                -- include ignored files but re-exclude heavy dirs
                find_command = {
                    'rg',
                    '--files',
                    '--hidden',
                    '--no-ignore-vcs',
                    '--glob',
                    '!**/{.git,node_modules,.next,.vercel,dist,build,.nx,.yarn,coverage}/**', -- glob to exclude patterns from finding
                },
            })
        end, { desc = '[S]earch [F]iles' })

        vim.keymap.set('n', '<leader>fe', function()
            require('telescope').extensions.file_browser.file_browser({
                path = vim.fn.expand('%:p:h'),
                select_buffer = true,
                respect_git_ignore = false,
                hidden = true,
                grouped = true,
                previewer = true,
                initial_mode = 'normal',
            })
        end, { desc = '[S]earch [T]ree' })
    end,
}
