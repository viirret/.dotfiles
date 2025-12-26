return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = true,
		})
		local fs = require("utils.fs")
		local is_nixos = fs.safe_stat("/etc/NIXOS") ~= nil
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local on_attach = require("keys.on_attach").on_attach

		require("config.plugins.lsp.lua").setup(capabilities, on_attach)
		require("config.plugins.lsp.python").setup(capabilities, on_attach)
		require("config.plugins.lsp.clang").setup(capabilities, on_attach, is_nixos)
	end,
}
