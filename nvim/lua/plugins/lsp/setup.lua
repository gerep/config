local on_attach_handler = function(client, buffer) end

vim.lsp.config("gopls", {
	on_attach = on_attach_handler,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	settings = {
		gopls = {
			completeUnimported = true,
		},
	},
})

vim.lsp.enable({ "gopls" })

vim.lsp.config("gdscript", {
	on_attach = on_attach_handler,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
})
vim.lsp.enable({ "gdscript" })

vim.filetype.add({
	extension = {
		gd = "gdscript",
	},
})
