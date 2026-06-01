-- PLUGINS

vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim",                version = "main" },
  { src = "https://github.com/folke/which-key.nvim",               version = "main" },
  { src = "https://github.com/brenoprata10/nvim-highlight-colors", version = "main" }
})


-- ACTIVATE PLUGINS

-- Auto Close Brackets
require('mini.pairs').setup()

-- Icons
require('mini.icons').setup()
-- Git
require('mini.git').setup()

-- Git Diff
require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = '+', change = '~', delete = '-' },
  },
})

---- mini notify ----
require("mini.notify").setup({
  -- only show messages
  content = {
    format = function(notif)
      return notif.msg
    end,
  },
})

-- Statusline
require('mini.statusline').setup({
  set_vim_settings=false,
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 50 })
      local git           = MiniStatusline.section_git({ trunc_width = 40 })
      local filename      = '%t%m%r'
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 250 })
      local location      = '%l:%v-%L'
      local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })


      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git } },
        '%<', -- Truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- Right align everything after this
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end
  }
})

-- Force your custom color overrides every time a theme loads
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, 'MiniStatuslineModeNormal',  { fg = '#1e1e2e', bg = '#a6e3a1', bold = true })
    set_hl(0, 'MiniStatuslineModeInsert',  { fg = '#1e1e2e', bg = '#f38ba8', bold = true })
    set_hl(0, 'MiniStatuslineModeVisual',  { fg = '#1e1e2e', bg = '#cba6f7', bold = true })
    set_hl(0, 'MiniStatuslineModeReplace', { fg = '#1e1e2e', bg = '#f9e2af', bold = true })
    set_hl(0, 'MiniStatuslineModeCommand', { fg = '#1e1e2e', bg = '#89b4fa', bold = true })
    set_hl(0, 'MiniStatuslineModeOther',   { fg = '#1e1e2e', bg = '#94e2d5', bold = true })
  end,
})

-- Trigger it once manually for your current session
vim.cmd('doautocmd ColorScheme')

-- Which Key popup
require('which-key').setup({
  delay = 0,
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },
})

-- Auto-Completions
-- require "mini.completion".setup()

-- Colorizer
require("nvim-highlight-colors").setup({ render = 'background' })
