return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = false,
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/notes",
			},
		},
		legacy_commands = false,
	},
	keys = {
		{
			"<leader>o",
			function()
				vim.cmd("Obsidian quick_switch")
			end,
			desc = "List Obsidian notes",
		},
	},
}
