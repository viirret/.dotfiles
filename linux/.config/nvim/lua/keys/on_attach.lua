-- LSP-related keymaps
local M = {}

function M.on_attach(_, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- LSP keymap
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
end

return M
