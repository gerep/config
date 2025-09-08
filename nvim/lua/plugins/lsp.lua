return {
	"neovim/nvim-lspconfig",
	version = "2.3.0",
	dependencies = {
		-- These are plugins that lspconfig can integrate with
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp", -- Autocompletion plugin
		{ "L3MON4D3/LuaSnip", version = "v2.4.0" },
	},
	config = function()
		local on_attach = function(_, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }

			if vim.lsp.buf.declaration then
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			end
			if vim.lsp.buf.definition then
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			end
			if vim.lsp.buf.hover then
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			end
			if vim.lsp.buf.rename then
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			end
			if vim.lsp.buf.code_action then
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end
			if vim.lsp.diagnostic.open_float then
				vim.keymap.set("n", "[e", vim.lsp.diagnostic.open_float, opts)
			end
			if vim.lsp.diagnostic.goto_prev then
				vim.keymap.set("n", "[d", vim.lsp.diagnostic.goto_prev, opts)
			end
			if vim.lsp.diagnostic.goto_next then
				vim.keymap.set("n", "]d", vim.lsp.diagnostic.goto_next, opts)
			end
			if vim.lsp.buf.code_action then
				vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code [A]ction" })
			end
			vim.keymap.set("n", "<C-f>", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
		end

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Go
		lspconfig.gopls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				gopls = {
					gofumpt = true, -- Use gofumpt for stricter formatting (optional)
					staticcheck = true, -- Enable static analysis
					analyses = {
						unusedparams = true,
					},
					hints = {
						parameterNames = true,
						assignVariableTypes = true,
					},
					-- Enable auto-imports during completion
					completeUnimported = true,
				},
			},
		})

		-- TypeScript / Vue
		lspconfig.ts_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		-- Vue (Volar)
		lspconfig.volar.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "vue" }, -- Explicitly set to vue
			init_options = {
				vue = {
					hybridMode = false, -- Use Take Over Mode for TypeScript in Vue
				},
			},
		})

		-- GDScript
		lspconfig.gdscript.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "netcat", "localhost", "6005" },
			filetypes = { "gd", "gdscript", "gdscript3" },
		})

		-- Lua
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					-- Tell the server where to find the Lua files for Neovim
					telemetry = { enable = false },
				},
			},
		})

		-- Python (Pyright)
		lspconfig.pyright.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				python = {
					pythonPath = vim.fn.exepath("python"), -- Default to any python in PATH
					venvPath = vim.fn.getcwd() .. "/.venv/", -- Point to the venv folder
					analysis = {
						autoImportCompletions = true, -- Enable auto-import suggestions
						typeCheckingMode = "basic", -- Options: "off", "basic", "strict"
					},
				},
			},
		})
	end,
}
