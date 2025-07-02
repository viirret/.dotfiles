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

-- Paste from os clipboard
map('n', '<M-v>', '"+p')
map('n', '<M-V>', '"+P')

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Vim motions for buffers
map('n', '<C-j>', ':bprevious<CR>')
map('n', '<C-k>', ':bnext<CR>')

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { noremap = true, silent = true})
vim.keymap.set('n', '<leader>fe', function()
  require('telescope').extensions.file_browser.file_browser({
    path = vim.loop.cwd(), -- Nvim launch path
    select_buffer = true,
  })
end, { noremap = true, silent = true, desc = "Telescope File Explorer" })

