return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()
			local lspkind = require("lspkind")

			cmp.setup({
				formatting = {
					fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
					expandable_indicator = false, -- Explicitly set to satisfy type requirement
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							require("luasnip").expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							require("luasnip").jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" }, { name = "cmdline" } }),
			})
		end,
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			require("neodev").setup()

			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			-- Global capabilities for LSP servers
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- Global on_attach function
			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				-- if client.server_capabilities.documentFormattingProvider then
				--     vim.api.nvim_create_autocmd("BufWritePre", {
				--         buffer = bufnr,
				--         callback = function()
				--             vim.lsp.buf.format({ async = false })
				--         end,
				--     })
				-- end
			end)

			require("mason-lspconfig").setup({
				automatic_installation = false,
				ensure_installed = { "lua_ls", "ts_ls", "gopls", "volar" },
				handlers = {
					-- Default handler applies on_attach and capabilities to all servers
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							on_attach = lsp_zero.on_attach,
						})
					end,
					-- Specific overrides
					ts_ls = function()
						require("lspconfig").ts_ls.setup({
							capabilities = capabilities,
							root_dir = require("lspconfig.util").root_pattern(
								"package.json",
								"tsconfig.json",
								"jsconfig.json"
							),
							single_file_support = true,
						})
					end,

					-- Specific handler for volar (Vue Language Server)
					volar = function() -- Use 'volar' as the key for lspconfig
						require("lspconfig").volar.setup({
							capabilities = capabilities,
							on_attach = lsp_zero.on_attach,
							filetypes = { "vue", "typescript", "javascript", "javascriptreact", "typescriptreact" }, -- Volar can handle TS/JS too, especially within Vue context
							init_options = {
								vue = {
									hybridMode = false,
								},
							},
							--[[ -- Optional: If you face issues with Volar taking over TS files outside Vue projects,
                                 -- you might constrain it, but usually letting it handle TS within Vue projects is fine.
                            init_options = {
                                typescript = {
                                    tsdk = "path/to/your/project/node_modules/typescript/lib" -- Point to project's TS install
                                }
                            }
                            --]]
						})
					end,

					lua_ls = function()
						require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls({
							capabilities = capabilities,
							on_attach = lsp_zero.on_attach,
						}))
					end,
					gopls = function()
						require("lspconfig").gopls.setup({
							capabilities = capabilities,
							on_attach = lsp_zero.on_attach,
							settings = {
								gopls = {
									staticcheck = true,
									gofumpt = true,
									analyses = {
										unusedparams = true,
										shadow = true,
										nilness = true,
										unusedwrite = true,
										useany = true,
									},
									codelenses = {
										gc_details = true,
										generate = true,
										regenerate_cgo = true,
										tidy = true,
										upgrade_dependency = true,
									},
									usePlaceholders = true,
									completeUnimported = true,
									directoryFilters = {
										"-.git",
										"-.vscode",
										"-.idea",
										"-.vscode-test",
										"-node_modules",
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- Or other events as needed
		cmd = { "ConformInfo" },
		-- We are using the 'config' function below, so no 'opts' table needed here
		config = function() -- Keep this config function!
			-- *** PASTE THE COPIED PATH HERE ***
			-- Make sure this path is correct for your system! Check :Mason again.
			local mason_prettierd_path = vim.fn.expand("~/.local/share/nvim/mason/bin/prettierd") -- Adjust if Mason uses a different path structure

			-- Call require('conform').setup() INSIDE the config function
			require("conform").setup({
				notify_on_error = true,
				format_on_save = {
					timeout_ms = 1000,
					lsp_fallback = false, -- Keep disabled while testing the fix
				},
				-- Use the custom 'mason_prettierd' formatter
				formatters_by_ft = {
					lua = { "stylua" },
					vue = { "mason_prettierd" },
					javascript = { "mason_prettierd" },
					typescript = { "mason_prettierd" },
					javascriptreact = { "mason_prettierd" },
					typescriptreact = { "mason_prettierd" },
					html = { "mason_prettierd" },
					css = { "mason_prettierd" },
					json = { "mason_prettierd" },
					go = { "gofmt", "goimports" },
					-- Add other filetypes...
				},
				-- Define the custom 'mason_prettierd' formatter
				formatters = {
					mason_prettierd = {
						command = mason_prettierd_path, -- The explicit path to the binary
						args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) }, -- Args for prettierd
						stdin = true, -- Use stdin
					},
				},
			}) -- End of require('conform').setup({...}) table
		end, -- End of config function
	},
	-- Linter Plugin (Example: nvim-lint)
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "BufReadPost", "InsertLeave" }, -- When to trigger linting
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				vue = { "eslint_d" },
				go = { "golangcilint" }, -- Requires 'golangci-lint' installed via Mason or otherwise
				lua = { "luacheck" }, -- Requires 'luacheck'
				-- Add other filetypes and linters
			}

			-- Configure linting to run automatically
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("nvim-lint-autogroup", { clear = true }),
				callback = function(event)
					-- Use a timer to debounce linting triggers
					local timer = vim.uv.new_timer()
					if timer then
						timer:start(
							100,
							0,
							vim.schedule_wrap(function()
								require("lint").try_lint()
								timer:close()
							end)
						)
					else
						require("lint").try_lint() -- Fallback if timer fails
					end
				end,
			})

			-- Optional: Keymap for manual linting
			vim.keymap.set("n", "<leader>ll", function()
				require("lint").try_lint()
			end, { desc = "[L]int Buffer" })
		end,
	},
}
