return {
    {
        'github/copilot.vim',
        version = "v1.50.0",
        -- Lazy-load on entering insert mode or when an LSP attaches
        event = { 'InsertEnter', 'LspAttach' },
        config = function()
            -- The plugin works out of the box, but you can add customizations here.
            -- For example, to change the key used to accept a suggestion.
            -- The default is <Tab>. Let's map <C-l> as an alternative.
            vim.keymap.set('i', '<C-l>', 'copilot#Accept("<CR>")', {
                expr = true,
                replace_keycodes = false,
                desc = "Accept Copilot Suggestion"
            })

            -- You can also disable it by default and toggle it on/off
            vim.g.copilot_enabled = true
        end
    }
}
