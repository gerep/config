return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8", -- Pin to a specific version for stability
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local telescope_builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					-- General settings for all pickers
					file_ignore_patterns = {
						"^__pycache__/",
						"^node_modules/",
						"^venv/",
						"%.venv/",
						"^%.git/",
						"%.o$",
						"%.pyc$",
						"%.class$",
					},
				},
				pickers = {
					find_files = {
						-- Use fd with ignore patterns
						find_command = {
							"fd",
							"--type",
							"f",
							"--strip-cwd-prefix",
							"--hidden", -- Include hidden files (optional)
							"--exclude",
							"__pycache__",
							"--exclude",
							"node_modules",
							"--exclude",
							"venv",
							"--exclude",
							".venv",
							"--exclude",
							".git",
						},
					},
					buffers = {
						mappings = {
							i = {
								["<C-d>"] = actions.delete_buffer,
							},
							n = {
								["d"] = actions.delete_buffer,
								["<C-d>"] = actions.delete_buffer,
							},
						},
					},
				},
			})

			-- General
			vim.keymap.set(
				"n",
				"<leader>tt",
				telescope_builtin.current_buffer_fuzzy_find,
				{ desc = "[T]elescope buffer fuzzy find" }
			)
			vim.keymap.set("n", "<leader>b", telescope_builtin.buffers, { desc = "[F]ind [B]uffers" })
			vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>j", telescope_builtin.jumplist, { desc = "[J]umplist" })
			vim.keymap.set("n", "<leader>k", telescope_builtin.help_tags, { desc = "[F]ind [H]elp" })
			vim.keymap.set(
				"n",
				"<leader>s",
				telescope_builtin.lsp_document_symbols,
				{ desc = "[F]ind [D]ocument Symbols" }
			)

			vim.keymap.set(
				"n",
				"<leader>S",
				telescope_builtin.lsp_dynamic_workspace_symbols,
				{ desc = "[S]earch workspace symbols" }
			)

			-- Grep
			vim.keymap.set("n", "*", telescope_builtin.grep_string, { desc = "[F]ind [S]tring under cursor" })
			vim.keymap.set("n", "<leader>/", telescope_builtin.live_grep, { desc = "[F]ind by [G]rep" })

			-- Git
			vim.keymap.set("n", "<leader>gf", telescope_builtin.git_files, { desc = "[G]it [F]iles" })
			vim.keymap.set("n", "<leader>gl", telescope_builtin.git_status, { desc = "[G]it [S]tatus" })

			vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, { desc = "Go to definition" })

			-- Diagnostics and LSP
			vim.keymap.set("n", "<leader>d", function()
				vim.diagnostic.setloclist({ bufnr = 0 })
				vim.cmd("lopen")
				vim.cmd("setlocal wrap")
			end, { desc = "[D]iagnostics for current [D]ocument" })
			vim.keymap.set("n", "<leader>D", function()
				vim.diagnostic.setloclist()
				vim.cmd("lopen")
				vim.cmd("setlocal wrap")
			end, { desc = "[D]iagnostics for all [D]ocuments" })

			-- Note: You have 'gr' mapped here and also in your lsp.lua. You should choose one.
			vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { desc = "[G]oto [R]eferences (Telescope)" })
			vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })
		end,
	},
	-- It's good practice to also explicitly include dependencies
	{
		"nvim-lua/plenary.nvim",
	},
}
