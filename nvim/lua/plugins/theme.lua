return {
    -- "rebelot/kanagawa.nvim",
    -- name = "kanagawa",
    -- priority = 1000,
    -- config = function()
    --     vim.cmd.colorscheme("kanagawa")
    -- end,
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('nordic').load()
    end
}
