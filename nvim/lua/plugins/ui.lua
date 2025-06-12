return {
    {
        'folke/which-key.nvim',
        event = 'VimEnter', -- Loads the plugin on startup
        config = function()
            require('which-key').setup({
                -- You can leave this empty to use the default settings
                -- Or configure it further later. The defaults are great.
            })
        end,
    },
}
