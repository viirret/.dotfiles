-- keys.lua
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Leader key
vim.g.mapleader = " "

-- Paste from os clipboard
map("n", "<M-v>", '"+p')
map("n", "<M-V>", '"+P')

-- Disable arrow keys
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

-- Ctrl j+k for swapping buffers.
map("n", "<C-j>", "<Cmd>BufferPrevious<CR>")
map("n", "<C-k>", "<Cmd>BufferNext<CR>")
