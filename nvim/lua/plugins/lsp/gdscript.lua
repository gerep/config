local lsp_util = require("lspconfig.util")
local godot_lsp_port = 6005

return {
	cmd = { "nc", "127.0.0.1", tostring(godot_lsp_port) },
	filetypes = { "gdscript" },
	root_dir = lsp_util.root_pattern("project.godot"),
	settings = {
		name = "GDScript",
		port = godot_lsp_port,
		host = "127.0.0.1",
	},
}
