return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                go = { "gofmt", "goimports" },
                python = { "black" },
                gdscript = { "gdformat" },
                vue = { "prettier" },
                typescript = { "prettier" },
                javascript = { "prettier" },
                json = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })

        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({ async = true, lsp_format = "fallback" })
        end, { desc = "Format buffer" })
    end,
}
