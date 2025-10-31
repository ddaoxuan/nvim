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

        local function dir_leaf(sel)
            local p = sel.path or sel.filename or sel.value
            if type(p) == 'table' then
                p = p.path or p.filename or p[1]
            end
            p = tostring(p or '')
            -- normalize and take last segment
            p = p:gsub('\\', '/')
            return (p:match('([^/]+)/?$')) or p
        end
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
            builtin.lsp_definitions({ jump_type = 'never' })
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
            { desc = 'search diagnostics' }
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
                    '!**/{.git,node_modules,.next,dist,build,.nx,.yarn,coverage}/**',
                },
            })
        end, { desc = 'search files' })

        -- File browser
        vim.keymap.set('n', '<leader>fe', function()
            telescope.extensions.file_browser.file_browser({
                path = vim.fn.expand('%:p:h'),
                select_buffer = true,
                respect_git_ignore = false,
                no_ignore = true,
                no_ignore_parent = true,
                hidden = true,
                grouped = true,
                previewer = true,
                initial_mode = 'normal',
            })
        end, { desc = 'file browser' })

        vim.keymap.set('n', '<leader>sD', function()
            local ignore_dirs = {
                'node_modules',
                '.next',
                'dist',
                '.vercel',
                'build',
                '.nx',
                '.yarn',
                'coverage',
            }
            builtin.find_files({
                prompt_title = 'Pick dir for grep',
                cwd = vim.loop.cwd(),
                find_command = {
                    'fd',
                    '-t',
                    'd', -- list directories only

                    -- ignore dirs
                    vim.tbl_map(function(d)
                        return { '--exclude', d }
                    end, ignore_dirs),
                },

                attach_mappings = function(_, map)
                    local open_selected_dir = function(prompt_bufnr)
                        local selection = action_state.get_selected_entry()

                        actions.close(prompt_bufnr)
                        builtin.live_grep({
                            cwd = selection.path,
                            prompt_title = dir_leaf(selection),
                        })
                    end

                    map('i', '<CR>', open_selected_dir)
                    map('n', '<CR>', open_selected_dir)

                    return true
                end,
            })
        end, { desc = 'Pick dir then live_grep' })

        vim.keymap.set('n', '<leader>st', function()
            builtin.colorscheme({
                ignore_builtins = true,
                enable_preview = true,
            })
        end, { desc = 'search theme' })
    end,
}
