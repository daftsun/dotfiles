-- PLUGINS

vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim",         version = "main",   name = "mini" },
    { src = "https://github.com/folke/which-key.nvim",        version = "main",   name = "which-key" },
    { src = "https://github.com/catgoose/nvim-colorizer.lua", version = "master", name = "colorizer" }
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

-- Statusline
require('mini.statusline').setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 50 })
      local git           = MiniStatusline.section_git({ trunc_width = 40 })
      local filename = MiniStatusline.section_filename({ trunc_width = 50 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 250 })
      local location      = '%l:%v-%L'
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })


      return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git } },
        '%<', -- Truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
	'%=', -- Right align everything after this
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end
  }
})

-- Which Key popup
require('which-key').setup({ delay = 0, preset = "modern", icons = { mappings = false } })

-- Auto-Completions
require "mini.completion".setup()

-- Colorizer
require("colorizer").setup({ options = { parsers = { css = true }}, })
