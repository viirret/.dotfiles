local M = {}

function M.setup(capabilities, on_attach)
	vim.lsp.config["nixd"] = {
		cmd = { "nixd" },
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "nix" },
		root_dir = function(fname)
			-- Look upward for common Nix project roots
			local root = vim.fs.find({ "flake.nix", "default.nix", ".git" }, { upward = true, path = fname })[1]
			return root and vim.fs.dirname(root) or vim.fn.getcwd()
		end,
		settings = {
			nixd = {
				nixpkgs = {
					expr = "import <nixpkgs> { }",
				},
				formatting = {
					command = { "nixfmt" },
				},
			},
		},
	}

	-- Automatically start nixd for Nix files
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "nix" },
		callback = function(args)
			local active = vim.lsp.get_clients({ bufnr = args.buf, name = "nixd" })
			if #active == 0 then
				local root = vim.fs.dirname(
					vim.fs.find({ "flake.nix", "default.nix", ".git" }, { upward = true, path = args.file })[1]
						or args.file
				)
				vim.lsp.start({
					name = "nixd",
					cmd = { "nixd" },
					capabilities = capabilities,
					on_attach = on_attach,
					root_dir = root,
					settings = {
						nixd = {
							nixpkgs = {
								expr = "import <nixpkgs> { }",
							},
							formatting = {
								command = { "nixfmt" },
							},
						},
					},
				})
			end
		end,
	})
end

return M
