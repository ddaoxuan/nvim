-- [[ Configure Telescope - Fuzzy Finder ]]
-- See `:help telescope` and `:help telescope.setup()`
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim', -- lua functions that telescope needs
    'nvim-telescope/telescope-file-browser.nvim', -- tree structure plugin
    'nvim-tree/nvim-web-devicons',
    {
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      'nvim-telescope/telescope-fzf-native.nvim', -- improve telescope sorting perf
      -- NOTE: If you are having trouble with this installation,
      -- refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local fb_actions = require('telescope').extensions.file_browser.actions

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next resultj
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist, -- send to qf list and open
          },
          n = {
            ['q'] = actions.close,
          },
        },
      },
      extensions = {
        file_browser = {
          theme = 'ivy',
          hijack_netrw = true, -- disables netrw add use telescope-file-browser in its place
          mappings = {
            ['i'] = {
              ['<C-w>'] = function()
                vim.cmd 'normal vbd'
              end,
            },
            ['n'] = {
              ['N'] = fb_actions.create,
              ['h'] = fb_actions.goto_parent_dir,
              ['/'] = function()
                vim.cmd 'startinsert'
              end,
            },
          },
        },
      },
    }

    telescope.load_extension 'fzf' -- Enable telescope fzf native, if installed
    telescope.load_extension 'file_browser' -- Enable telescope fzf native, if installed

    -- [[ Telescope keymaps ]]
    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set(
      'n',
      '<leader>fb',
      ':Telescope file_browser path=%:p:h select_buffer=true respect_git_ignore=false hidden=true grouped=true previewer=true initial_mode=normal<CR>',
      { desc = '[S]earch [T]ree' }
    )
  end,
}
