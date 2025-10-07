vim.g.mapleader = " "

-- Basic Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 2
vim.opt.hidden = true
vim.opt.visualbell = true
vim.opt.grepprg = "rg --vimgrep"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Key mappings for LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
-- vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})

-- Diagnostics key mappings
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})
vim.keymap.set("n", "<leader>Q", vim.diagnostic.setqflist, {})
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, {})
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, {})

-- Auto-format Go files on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.code_action({
			context = {
				only = { "source.organizeImports" },
				diagnostics = {},
			},
			apply = true,
		})
		vim.lsp.buf.format({ async = false })
	end,
})

-- Auto-format Lua files on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.lua",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Manual format key mapping
vim.keymap.set("n", "<leader>fmt", vim.lsp.buf.format, {})

-- Setup plugins
require("lazy").setup({
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false,
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false,
				dimInactive = false,
				terminalColors = true,
				colors = {
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				theme = "wave",
				background = {
					dark = "wave",
					light = "lotus",
				},
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	-- Git signs for line changes
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})

			-- Navigation between git changes
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					require("gitsigns").nav_hunk("next", nil)
				end
			end)
			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					require("gitsigns").nav_hunk("prev", nil)
				end
			end)
		end,
	},

	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Use the new vim.lsp.config API
			vim.lsp.config.gopls = {
				cmd = { "gopls" },
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			}

			vim.lsp.config.lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields", "param-type-mismatch" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			}

			vim.lsp.config.ts_ls = {
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			}

			vim.lsp.config.vue_ls = {
				settings = {
					vue = {
						complete = {
							casing = {
								tags = "kebab",
								props = "camel",
							},
						},
					},
				},
			}

			-- Enable the LSP servers
			vim.lsp.enable("gopls")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("vue_ls")

			-- Godot LSP with manual connection
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "gdscript" },
				callback = function()
					vim.lsp.start({
						name = "gdscript",
						cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
						root_dir = vim.fs.root(0, { "project.godot", ".git" }),
					})
				end,
			})
		end,
	},

	-- Telescope for fuzzy finding
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					sorting_strategy = "ascending",
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					use_less = true,
					path_display = {},
					set_env = { ["COLORTERM"] = "truecolor" },
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
			})

			local builtin = require("telescope.builtin")

			-- File and buffer navigation
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>fc", builtin.commands, {})
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

			-- LSP-related
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, {})

			-- Git integration
			vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
			vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
			vim.keymap.set("n", "gr", builtin.lsp_references, {})
			vim.keymap.set("n", "gi", builtin.lsp_implementations, {})

			-- Search
			vim.keymap.set("n", "<leader>ft", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = "/home/daniel/notes" })
			end, {})
		end,
	},

	-- Treesitter for better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "go", "lua", "vim", "vimdoc", "query", "typescript", "javascript", "vue" },
				auto_install = true,
				sync_install = false,
				ignore_install = {},
				modules = {},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	-- Undotree for undo history
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", {})
		end,
	},

	-- Conform for formatting
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					vue = { "prettierd", "eslint" },
					css = { "prettierd" },
					markdown = { "prettierd" },
					lua = { "stylua" },
					go = { "goimports" },
					gdscript = { "gdformat" },
				},
				formatters = {
					eslint = {
						condition = function()
							return vim.fs.root(
								0,
								{ ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml", "eslint.config.js" }
							) ~= nil
						end,
					},
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
	},

	-- Obsidian for note-taking
	{
		"epwalsh/obsidian.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "notes",
						path = "/home/daniel/notes",
					},
				},
				daily_notes = {
					folder = "daily",
					date_format = "%Y-%m-%d",
				},
				completion = {
					nvim_cmp = true,
					min_chars = 2,
				},
				mappings = {},
			})

			-- Telescope-based note management
			vim.keymap.set("n", "<leader>of", function()
				require("telescope.builtin").find_files({ cwd = "/home/daniel/notes" })
			end, {})

			vim.keymap.set("n", "<leader>os", function()
				require("telescope.builtin").live_grep({ cwd = "/home/daniel/notes" })
			end, {})

			-- Obsidian key mappings
			vim.keymap.set("n", "<leader>on", ":ObsidianNew ", {})
			vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", {})
			vim.keymap.set("n", "<leader>ob", ":ObsidianBacklinks<CR>", {})
		end,
	},

	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				default_file_explorer = false,
				view_options = {
					show_hidden = false,
				},
			})

			-- Toggle Oil in a floating window (modal)
			vim.keymap.set("n", "<leader>e", function()
				require("oil").toggle_float()
			end, { desc = "Oil (float)" })
		end,
	},

	-- File tree on the right side
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Disable netrw
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({
				view = {
					side = "left",
					width = 35,
				},
				update_focused_file = {
					enable = true,
					update_root = false,
					ignore_list = {},
				},
				git = {
					enable = true,
					ignore = false,
				},
				filesystem_watchers = {
					enable = true,
				},
				actions = {
					open_file = {
						quit_on_open = false,
					},
				},
				renderer = {
					highlight_git = true,
					icons = {
						show = {
							git = true,
						},
					},
				},
			})

			-- Toggle file tree
			vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>h", mark.add_file)
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

			vim.keymap.set("n", "<leader>1", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<leader>2", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<leader>3", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<leader>4", function()
				ui.nav_file(4)
			end)
		end,
	},
	-- Comment plugin for toggling comments
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<C-c>", -- Line-comment toggle keymap
					block = "<leader>bc", -- Block-comment toggle keymap
				},
				opleader = {
					line = "<C-c>", -- Line-comment operator-pending keymap
					block = "<leader>bc", -- Block-comment operator-pending keymap
				},
				extra = {
					above = "<leader>cO", -- Add comment on the line above
					below = "<leader>co", -- Add comment on the line below
					eol = "<leader>cA", -- Add comment at the end of line
				},
				mappings = {
					basic = true,
					extra = true,
				},
			})
		end,
	},
})

vim.keymap.set("n", "<leader>S", function()
	if vim.opt_local.spell:get() then
		vim.opt_local.spell = false
		print("Spell check disabled")
	else
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
		print("Spell check enabled")
	end
end, {})
vim.keymap.set("n", "<leader>n", ":cnext<CR>", {})
vim.keymap.set("n", "<leader>N", ":cprevious<CR>", {})

-- Disable middle mouse button (prevents accidental paste)
vim.keymap.set("n", "<MiddleMouse>", "<Nop>", {})
vim.keymap.set("n", "<2-MiddleMouse>", "<Nop>", {})
vim.keymap.set("i", "<MiddleMouse>", "<Nop>", {})
vim.keymap.set("i", "<2-MiddleMouse>", "<Nop>", {})

-- File type specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "vue" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.autoindent = false
		vim.opt_local.cindent = false
		vim.opt_local.smartindent = false
		vim.opt_local.textwidth = 100
	end,
})

vim.keymap.set("n", "<F5>", function()
	local project_root = vim.fn.getcwd() -- Get the current working directory
	local file_extension = vim.fn.expand("%:e") -- Get the file extension
	if file_extension == "go" then
		vim.cmd("!cd " .. project_root .. " && go build .")
		print("Running go build in: " .. project_root)
	elseif file_extension == "gd" then
		vim.cmd("!cd " .. project_root .. " && /opt/godot/godot --no-window")
		print("Running Godot game in: " .. project_root)
	else
		print("No action defined for file type: " .. file_extension)
	end
end, {})

vim.keymap.set("n", "<F6>", function()
	local project_root = vim.fn.getcwd() -- Get the current working directory
	local file_extension = vim.fn.expand("%:e") -- Get the file extension
	if file_extension == "gd" then
		local scene_name = vim.fn.expand("%:t:r") .. ".tscn" -- Get the scene name (e.g., carrot.gd -> carrot.tscn)
		local scene_path = vim.fn.expand("%:p:h") .. "/" .. scene_name -- Construct full path to the .tscn file
		vim.cmd("!cd " .. project_root .. " && /opt/godot/godot --path " .. project_root .. " " .. scene_path)
		print("Running Godot scene: " .. scene_path)
	else
		print("F6 is only defined for GDScript files (.gd)")
	end
end, {})

-- Clipboard key mappings
vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>p", '"+p', {})

vim.keymap.set("n", "<leader>rs", function()
	for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
		vim.lsp.stop_client(client.id, true)
	end
	vim.cmd("edit") -- reloads buffer, triggering LSP startup again
	print("LSP restarted")
end)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
	vim.cmd("write")
end)
