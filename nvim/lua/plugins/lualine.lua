return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		theme = "auto",
		icons_enabled = true,
		sections = {
			lualine_c = {
				{
					"filename",
					path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
				},
			},
		},
	},
}
