local util = require('lspconfig.util')

-- Path para o @vue/typescript-plugin (vem junto com vue-language-server)
local function get_vue_plugin_path()
    local mason_path = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
    -- Se não usar mason, troque por algo tipo '/usr/lib/node_modules/@vue/language-server'
    return mason_path
end

return {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = get_vue_plugin_path(),
                        languages = { 'vue' },
                    },
                },
            },
        },
    },
}
