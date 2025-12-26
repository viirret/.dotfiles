local M = {}

function M.setup(capabilities, on_attach)
	local fn = vim.fn
	local fs = require("utils.fs")

	local function detect_rust_analyzer()
		local paths = {
			-- system pkg
			"/run/current-system/sw/bin/rust-analyzer",
			-- home-manager
			"/etc/profiles/per-user/"
				.. os.getenv("USER")
				.. "/bin/rust_analyzer",
		}
		for _, p in ipairs(paths) do
			if fs.safe_stat(p) then
				return p
			end
		end

		local ra = fn.exepath("rust-analyzer")
		if ra ~= "" then
			return ra
		end
		vim.notify("[LSP] rust analyzer not found!", vim.log.levels.ERROR)
		return nil
	end

	local ra_bin = detect_rust_analyzer()
	if not ra_bin then
		return
	end

	vim.lsp.config["rust_analyzer"] = {
		cmd = { ra_bin },
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "rust" },
		root_dir = vim.fs.dirname(
			vim.fs.find({ "Cargo.toml", ".git" }, { upward = true, path = vim.api.nvim_buf_get_name(0) })[1]
		),
		settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true },
				checkOnSave = true,
				diagnostics = { enable = true },
			},
		},
	}

	-- Auto-start for Rust files
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "rust" },
		callback = function(args)
			local active = vim.lsp.get_clients({ bufnr = args.buf, name = "rust_analyzer" })
			if #active == 0 then
				local bufname = vim.api.nvim_buf_get_name(args.buf)
				local root = vim.fs.dirname(
					vim.fs.find({ "Cargo.toml", ".git" }, { upward = true, path = bufname })[1] or bufname
				)
				vim.lsp.start({
					name = "rust_analyzer",
					cmd = { ra_bin },
					capabilities = capabilities,
					on_attach = on_attach,
					root_dir = root,
					settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							checkOnSave = true,
							diagnostics = { enable = true },
						},
					},
				})
			end
		end,
	})
end

return M
