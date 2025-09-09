vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.cursorline = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

-- Check if the undodir file exists.
-- If it doesn't, Neovim will not create it, and undofile will silently fail.
local undodir = os.getenv("HOME") .. "/.vim/undodir"
if not vim.fn.isdirectory(undodir) then
    vim.fn.mkdir(undodir, "p", 0700)
end
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.colorcolumn = "80,120"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "gitcommit" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
})

-- Ensure mappings respond quickly.
vim.opt.timeoutlen = 300

-- Better splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Better search
vim.opt.inccommand = "split"
