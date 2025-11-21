return {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	settings = {
		vue = {
			inlayHints = {
				expressionType = {
					enabled = true,
					includeInferred = true,
				},
				functionParameterType = {
					enabled = true,
				},
				propertyDeclarationType = {
					enabled = true,
				},
				implicitExpectAnyParamType = {
					enabled = true,
				},
			},
		},
	},
}
