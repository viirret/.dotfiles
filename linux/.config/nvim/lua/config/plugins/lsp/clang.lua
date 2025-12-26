local M = {}

function M.setup(capabilities, on_attach, is_nixos)
	local fs = require("utils.fs")

	local function detect_clangd()
		if is_nixos then
			local user_clangd = "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/clangd"
			if fs.safe_stat(user_clangd) then
				return user_clangd
			end

			local nix_system_clangd = "/run/current-system/sw/bin/clangd"
			if fs.safe_stat(nix_system_clangd) then
				return nix_system_clangd
			end
		end

		local clangd = vim.fn.exepath("clangd")
		if clangd ~= "" then
			return clangd
		end

		vim.notify("[LSP] clangd not found in PATH or Nix profiles!", vim.log.levels.ERROR)
		return nil
	end

	local clangd_bin = detect_clangd()
	if not clangd_bin then
		vim.notify("Clangd not found", vim.log.levels.ERROR)
		return nil
	end

	local clangd_config = {
		name = "clangd",
		cmd = { clangd_bin, "--header-insertion=never" },
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	}

	-- Register clangd in vim.lsp.config
	vim.lsp.config["clangd"] = clangd_config

	-- Automatically start clangd for C/C++ buffers
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		callback = function(args)
			local active = vim.lsp.get_clients({ bufnr = args.buf, name = "clangd" })
			if #active == 0 then
				local path = vim.api.nvim_buf_get_name(args.buf)
				local root = vim.fs.root(args.buf, {
					"compile_commands.json",
					".git",
				}) or vim.loop.cwd()
				vim.lsp.start({
					name = clangd_config.name,
					cmd = clangd_config.cmd,
					capabilities = clangd_config.capabilities,
					on_attach = clangd_config.on_attach,
					root_dir = root,
				})
			end
		end,
	})
end

return M
