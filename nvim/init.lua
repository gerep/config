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

-- I don't know where to put this command, so I'll leave it here for now.
vim.cmd([[command! W write]])
vim.cmd([[command! Q quit]])

vim.opt.rtp:prepend(lazypath)

require("golang")
require("set")
require("remap")
require("gitopen")
require("lazy").setup("plugins")
