vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80,120"
vim.opt.laststatus = 0
vim.opt.list = true
vim.opt.listchars = { leadmultispace = "│   ", tab = "  " }
vim.opt.autowriteall = true

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { silent = true })
vim.keymap.set("n", "<C-n>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<C-p>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>x", ":bd<CR>", { silent = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "sainnhe/everforest",
        priority = 1000,
        config = function()
            vim.g.everforest_background = "hard"
            vim.cmd.colorscheme("everforest")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            vim.treesitter.language.register("markdown", "mdx")
        end,
    },

    {
        "ibhagwan/fzf-lua",
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({ "fzf-native", winopts = { preview = { hidden = "nohidden" } } })
            vim.keymap.set("n", "<leader>f", fzf.files)
            vim.keymap.set("n", "<leader>g", fzf.live_grep)
            vim.keymap.set("n", "<leader>b", fzf.buffers)
            vim.keymap.set("n", "<leader>s", fzf.lsp_document_symbols)
            vim.keymap.set("n", "<leader>S", fzf.lsp_workspace_symbols)
            vim.keymap.set("n", "<leader>gt", fzf.git_status)
        end,
    },

    { "hrsh7th/cmp-nvim-lsp" },

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },

    {
        "williamboman/mason.nvim",
        config = function() require("mason").setup() end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "gopls",
                    "pyright",
                    "lua-language-server",
                    "vue-language-server",
                    "typescript-language-server",
                    "prettier",
                    "goimports",
                    "gofumpt",
                    "ruff",
                },
            })
        end,
    },

    {
        "stevearc/oil.nvim",
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        lazy = false,
        config = function()
            require("oil").setup({
                view_options = { show_hidden = true },
                float = {
                    padding = 2,
                    max_width = 90,
                    max_height = 30,
                    border = "rounded",
                    win_options = { winblend = 20 },
                    preview_split = "right",
                },
            })
            vim.keymap.set("n", "<leader>-", function() require("oil").toggle_float() end)
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = require("gitsigns")
                local map = function(mode, l, r)
                    vim.keymap.set(mode, l, r, { buffer = bufnr })
                end
                map("n", "]c", function()
                    if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
                end)
                map("n", "[c", function()
                    if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
                end)
                map("n", "<leader>gf", gs.preview_hunk)
                map("n", "<leader>gi", gs.preview_hunk_inline)
                map("n", "<leader>gs", gs.stage_hunk)
                map("n", "<leader>gS", gs.stage_buffer)
                map("n", "<leader>gr", gs.reset_hunk)
                map("n", "<leader>gR", gs.reset_buffer)
                map("n", "<leader>gd", gs.diffthis)
                map("n", "<leader>gq", gs.setqflist)
                map("n", "<leader>gD", function() gs.diffthis("~") end)
                map("n", "<leader>gb", function() gs.blame_line({ full = true }) end)
            end,
        },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-e>"] = cmp.mapping.abort(),
                }),
                sources = { { name = "nvim_lsp" } },
            })
        end,
    },

    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    go = { "goimports", "gofumpt" },
                    python = { "ruff_format" },
                    vue = { "prettier" },
                    typescript = { "prettier" },
                    javascript = { "prettier" },
                    json = { "prettier" },
                },
                format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
            })
        end,
    },
}, { performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } } })

-- LSP setup using native vim.lsp.config (Neovim 0.11+)
local caps = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        -- Disable default grr/gri/gra/grn mappings (silently ignore if not set)
        pcall(vim.keymap.del, "n", "grr", { buffer = args.buf })
        pcall(vim.keymap.del, "n", "gri", { buffer = args.buf })
        pcall(vim.keymap.del, "n", "gra", { buffer = args.buf })
        pcall(vim.keymap.del, "n", "grn", { buffer = args.buf })


    end,
})

vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
    capabilities = caps,
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
        },
    },
})

vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    root_markers = { "tsconfig.json", "package.json", ".git" },
    capabilities = caps,
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vim.fn.stdpath("data") ..
                    "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                languages = { "vue" },
            },
        },
    },
})

vim.lsp.config("volar", {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "vue.config.js", "nuxt.config.ts", "package.json" },
    capabilities = caps,
})

vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
    capabilities = caps,
})

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    capabilities = caps,
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

vim.lsp.enable({ "gopls", "ts_ls", "volar", "pyright", "lua_ls" })
