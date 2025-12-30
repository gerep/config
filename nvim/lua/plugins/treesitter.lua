return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            modules = {},
            sync_install = false,
            ignore_install = {},
            auto_install = true,
            ensure_installed = {
                "javascript",
                "typescript",
                "gdscript",
                "lua",
                "go",
                "python",
                "markdown",
                "markdown_inline",
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
