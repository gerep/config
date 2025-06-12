return {
    {
        'catppuccin/nvim',
        priority = 1000, -- Make sure this loads first
        config = function()
            vim.cmd.colorscheme('catppuccin-mocha')
        end,
    },
}
