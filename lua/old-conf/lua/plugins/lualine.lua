return {
  'hoob3rt/lualine.nvim', -- Status line
  dependencies = {
    'kyazdani42/nvim-web-devicons', -- File icons
  },

  config = function()
    local lualine = require 'lualine'
    lualine.setup {

      lualine.setup {
        options = {
          icons_enabled = true,
          theme = 'dracula',
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_ = {
            {
              'filename',
              file_status = true, -- displays file status
              path = 0, -- 0 = just filename
            },
          },
          lualine_x = {
            { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
            'encoding',
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'filename',
              file_status = true,
              path = 1, -- 1 = relative path
            },
          },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { 'fugitive' },
      },
    }
  end,
}
