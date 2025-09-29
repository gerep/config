return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ts_ls",
                    "volar",
                    "lua_ls",
                    "pyright",
                    "gopls",
                },
                automatic_installation = true,
            })
        end,
    },
}
