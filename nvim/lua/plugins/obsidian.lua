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
			"<leader>of",
			function()
				vim.cmd("Obsidian quick_switch")
			end,
		},
	},
}
