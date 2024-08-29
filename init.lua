vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.g.have_nerd_font = true

vim.g.dbs = {
  { name = 'dev-uni', url = 'postgresql://redglasses:RedGlasses1234!@university-dev.ce0kvdlb3mqz.us-east-1.rds.amazonaws.com/postgres' },
  { name = 'dev-identity', url = 'postgresql://redglasses:RedGlasses1234!@identity-dev.ce0kvdlb3mqz.us-east-1.rds.amazonaws.com/postgres' },
  { name = 'dev-product', url = 'postgresql://redglasses:RedGlasses1234!@product-dev.ce0kvdlb3mqz.us-east-1.rds.amazonaws.com/postgres' },
  { name = 'dev-adopt', url = 'postgresql://redglasses:RedGlasses1234!@adopt-proxy-dev.proxy-ce0kvdlb3mqz.us-east-1.rds.amazonaws.com/postgres' },
  {
    name = 'dev-delivery',
    url = 'postgresql://redglasses:739ec2e8-ad7e-43ec-a913-71731ad3bb99@delivery-dev.ce0kvdlb3mqz.us-east-1.rds.amazonaws.com/postgres',
  },
  { name = 'uat-identity', url = 'postgresql://redglasses:RedGlasses1234!@identity-uat.cgxsewmqyram.us-east-1.rds.amazonaws.com/postgres' },
  { name = 'prod-partner', url = 'postgresql://redglasses_readonly:gouFTYa1!$xvX@localhost:63338/postgres' },
  { name = 'prod-identity', url = 'postgresql://redglasses_readonly:gouFTYa1!$xvX@localhost:63337/postgres' },
  { name = 'prod-adopt', url = 'postgresql://redglasses_readonly:gouFTYa1!$xvX@localhost:63336/postgres' },
  { name = 'prod-product', url = 'postgresql://redglasses_readonly:gouFTYa1!$xvX@localhost:63335/postgres' },
  { name = 'prod-delivery', url = 'postgresql://redglasses_readonly:gouFTYa1!$xvX@localhost:63334/postgres' },
  { name = 'prod-uni', url = 'postgresql://redglasses_readonly:gouFTYa1!$xvX@localhost:63333/postgres' },
}

-- KEYMAPPINGS
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
