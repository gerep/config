return {
	"mbbill/undotree",
	version = "v6.1",
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	end,
}
