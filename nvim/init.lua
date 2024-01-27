local config_path = vim.fn.stdpath('config')
package.path = config_path .. '/?.lua;' .. config_path .. '/?/init.lua;' .. package.path

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("gerep")
require("lazy").setup({
    require("after.plugins.telescope"),
    require("after.plugins.colour"),
    require("after.plugins.treesitter"),
    require("after.plugins.harpoon"),
    require("after.plugins.undotree"),
    require("after.plugins.lsp"),
    require("after.plugins.gitsigns"),
    "nvim-treesitter/playground",
    "tpope/vim-surround",
})
