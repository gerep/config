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

-- Auto-start Godot LSP for GDScript files
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

-- Auto-start gopls for Go files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "gomod", "gowork", "gotmpl" },
	callback = function()
		vim.lsp.start({
			name = "gopls",
			cmd = { "/home/daniel/go/bin/gopls" },
			root_dir = vim.fs.root(0, { "go.mod", ".git" }),
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
		})
	end,
})

-- Auto-start lua_ls for Lua files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua" },
	callback = function()
		vim.lsp.start({
			name = "lua_ls",
			cmd = { "lua-language-server" },
			root_dir = vim.fs.root(0, {
				".luarc.json",
				".luarc.jsonc",
				".luacheckrc",
				".stylua.toml",
				"stylua.toml",
				"selene.toml",
				"selene.yml",
				".git",
			}),
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
		})
	end,
})

-- Auto-start typescript-language-server for TS/JS files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	callback = function()
		vim.lsp.start({
			name = "typescript-language-server",
			cmd = { "typescript-language-server", "--stdio" },
			root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }),
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
		})
	end,
})

-- Auto-start volar for Vue files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "vue" },
	callback = function()
		vim.lsp.start({
			name = "volar",
			cmd = { "vue-language-server", "--stdio" },
			root_dir = vim.fs.root(0, { "package.json", ".git" }),
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
		})
	end,
})

-- Key mappings for LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
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
		"kar9222/minimalist.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("minimalist")
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

	-- fzf for simple fuzzy finding
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
		config = function()
			-- fzf key mappings
			vim.keymap.set("n", "<leader>ff", ":Files<CR>", {})
			vim.keymap.set("n", "<leader>fg", ":Rg<CR>", {})
			vim.keymap.set("n", "<leader>fb", ":Buffers<CR>", {})
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

			-- Custom fzf-based note finder
			vim.keymap.set("n", "<leader>of", function()
				local current_dir = vim.fn.getcwd()
				vim.cmd("cd /home/daniel/notes")
				vim.cmd("Files")
				vim.cmd("cd " .. current_dir)
			end, {})

			-- Custom fzf-based note search
			vim.keymap.set("n", "<leader>os", function()
				local current_dir = vim.fn.getcwd()
				vim.cmd("cd /home/daniel/notes")
				vim.cmd("Rg")
				vim.cmd("cd " .. current_dir)
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
				default_file_explorer = true,
				view_options = {
					show_hidden = false,
				},
				-- Optional: float window tweaks (safe defaults)
				-- float = {
				--   padding = 2,
				--   max_width = 0.9,
				--   max_height = 0.9,
				--   border = "rounded",
				-- },
			})

			-- Toggle Oil in a floating window (modal)
			vim.keymap.set("n", "<leader>e", function()
				require("oil").toggle_float()
			end, { desc = "Oil (float)" })
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
vim.keymap.set("n", "<leader>gs", function()
	require("gitsigns").setqflist("all")
	vim.cmd("copen")
end)
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
