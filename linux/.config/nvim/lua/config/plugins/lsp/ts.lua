local M = {}

function M.setup(capabilities, on_attach)
	vim.lsp.config["vtsls"] = {
		cmd = { "vtsls", "--stdio" },
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		root_files = { "tsconfig.json", "package.json", "jsconfig.json", "git" },
		settings = {
			typescript = {
				updateImportsOnRename = "always",
				suggest = {
					completeFunctionCalls = true,
				},
			},
			javascript = {
				updateImportsOnRename = "always",
			},
		},
	}

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		callback = function(args)
			local active = vim.lsp.get_clients({ bufnr = args.buf, name = "vtsls" })
			if #active == 0 then
				local root = root
				vim.lsp.start({
					name = "vtsls",
					cmd = { "vtsls", "--stdio" },
					capabilities = capabilities,
					on_attach = on_attach,
					root_dir = root_dir,
					settings = {
						typescript = {
							updateImportsOnRename = "always",
						},
					},
				})
			end
		end,
	})
end

return M
