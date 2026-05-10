-- GLOBALS

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.clipboard = "osc52"

-- OPTIONS

vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true                          -- Enable break indent
vim.opt.undofile = true                             -- Save undo history
vim.opt.ignorecase = true                           -- Case-insensitive searching
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'                          -- Keep signcolumn on by default
vim.opt.updatetime = 250                            -- Decrease update time
vim.opt.timeoutlen = 300                            -- Decrease mapped sequence wait time
vim.opt.splitright = true                           -- Configure how new splits should be opened
vim.opt.splitbelow = true
vim.opt.list = true                                 -- Sets how neovim will display whitespace characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'                        -- Preview substitutions live, as you type!
vim.opt.cursorline = true                           -- Show which line your cursor is on
vim.opt.scrolloff = 10                              -- No of screen lines to keep above and below the cursor.
vim.opt.confirm = true                              -- Confirmation Box
vim.opt.winborder = 'rounded'                       -- default border for all floating windows
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }    -- clipboard settings
vim.opt.completeopt = 'menu,menuone,fuzzy,noinsert' -- Options for insert mode completion
vim.opt.termguicolors = true

-- AUTOCMD

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
}
)

--  KEYMAPS

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights on search' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set({"n", "v"}, "d", '"_d', {noremap = true})
vim.keymap.set({"n", "v"}, "x", '"_x', {noremap = true})
