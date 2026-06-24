return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "c",
            "cpp",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "go",
            "rust",
            "python",
            "typescript",
            "javascript",
            "html",
            "css",
            "json",
            "yaml",
            "toml",
            "markdown",
            "markdown_inline",
            "bash",
            "nix",
        },
        auto_install = true,
        highlight = {
            enable = false,
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        local orig_get_node_text = vim.treesitter.get_node_text
        if orig_get_node_text then
            vim.treesitter.get_node_text = function(node, source, opts)
                local ok, result = pcall(orig_get_node_text, node, source, opts)
                if ok then
                    return result
                end
                return ""
            end
        end
    end,
}
