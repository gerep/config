return {
    "neovim/nvim-lspconfig",
    version = "2.3.0",
    dependencies = {
        -- These are plugins that lspconfig can integrate with
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp", -- Autocompletion plugin
        "L3MON4D3/LuaSnip"  -- Snippet engine
    },
    config = function()
        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "<C-f>", vim.lsp.buf.format)
            -- Add format-on-save functionality
            if client.supports_method("textDocument/formatting") then
                local format_augroup = vim.api.nvim_create_augroup("LspFormat", { clear = true })
                vim.api.nvim_create_autocmd(
                    "BufWritePre",
                    {
                        group = format_augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end
                    }
                )
            end
        end

        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Go
        lspconfig.gopls.setup(
            {
                on_attach = on_attach,
                capabilities = capabilities
            }
        )

        -- TypeScript / Vue
        lspconfig.ts_ls.setup(
            {
                on_attach = on_attach,
                capabilities = capabilities
            }
        )
        lspconfig.volar.setup(
            {
                -- For Vue
                on_attach = on_attach,
                capabilities = capabilities
            }
        )

        -- GDScript
        lspconfig.gdscript.setup(
            {
                on_attach = on_attach,
                capabilities = capabilities
            }
        )

        -- Lua
        lspconfig.lua_ls.setup(
            {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        -- Tell the server where to find the Lua files for Neovim
                        telemetry = { enable = false }
                    }
                }
            }
        )
    end
}
