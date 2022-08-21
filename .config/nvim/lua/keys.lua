-- keys.lua
-- key mapping

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Leader key
vim.g.mapleader = " "

-- easy switching between tabs
map("n", "<C-j>", '<cmd>tabprev<cr>')
map("n", "<C-k>", '<cmd>tabnext<cr>')

-- paste from os clipboard
map('n', '<M-v>', '"+p')
map('n', '<M-V>', '"+P')

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')


