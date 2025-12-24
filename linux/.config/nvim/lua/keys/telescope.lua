local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fe", function()
	require("telescope").extensions.file_browser.file_browser({
		path = vim.loop.cwd(), -- Nvim launch path
		select_buffer = true,
	})
end, { noremap = true, silent = true, desc = "Telescope File Explorer" })
