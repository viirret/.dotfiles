local M = {}

function M.setup(capabilities, on_attach)
	vim.lsp.config["pylsp"] = {
		cmd = { "pylsp" },
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "python" },
		settings = {
			pylsp = {
				plugins = {
					pyflakes = { enabled = true },
					pycodestyle = { enabled = true },
					black = { enabled = false },
					ruff = { enabled = true },
					pylsp_mypy = { enabled = false },
				},
			},
		},
	}

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "python" },
		callback = function(args)
			local active = vim.lsp.get_clients({ bufnr = args.buf, name = "pylsp" })
			if #active == 0 then
				vim.lsp.start({
					name = "pylsp",
					cmd = { "pylsp" },
					capabilities = capabilities,
					on_attach = on_attach,
					root_dir = vim.fs.dirname(
						vim.fs.find({ "pyproject.toml", "setup.py", ".git" }, { upward = true, path = args.file })[1]
					),
				})
			end
		end,
	})
end

return M
