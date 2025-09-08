return {
	-- Godot scene file support
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "gdscript" })
		end,
	},
	-- Additional file type associations for Godot
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		config = function()
			-- Set up file associations for Godot files
			vim.filetype.add({
				extension = {
					gd = "gdscript",
					cs = "cs", -- For C# scripts in Godot
					tscn = "tscn", -- Godot scene files
					tres = "tres", -- Godot resource files
				},
				pattern = {
					[".*%.godot"] = "godot",
					["project%.godot"] = "godot",
				},
			})
		end,
	},
}
