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
vim.opt.updatetime = 250
vim.opt.colorcolumn = "80,120"
vim.opt.laststatus = 2
vim.opt.statusline = " %f"
vim.opt.list = true
vim.opt.listchars = { leadmultispace = "│   ", tab = "» " }
vim.opt.autowriteall = true

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Cmd>w<CR><Esc>", { silent = true, desc = "Save file and exit insert mode" })
vim.keymap.set("n", "<C-n>", function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "scratch" then
            vim.api.nvim_win_close(win, true)
            return
        end
    end
    vim.cmd("botright vnew")
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = "scratch"
end, { silent = true, desc = "Toggle scratch notes buffer" })
vim.keymap.set("n", "]b", ":bn<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "[b", ":bp<CR>", { silent = true, desc = "Previous buffer" })
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
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                dim_inactive = true,
            })
            vim.cmd.colorscheme("kanagawa")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = { auto_install = true },
        config = function()
            vim.treesitter.language.register("markdown", "mdx")
        end,
    },

    {
        "ibhagwan/fzf-lua",
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({
                "fzf-native",
                winopts = { preview = { hidden = "nohidden" } },
                files = {
                    fd_opts = "--type f --hidden --follow --exclude .git --exclude vendor --exclude node_modules",
                },
                grep = {
                    rg_opts =
                    "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git' -g '!vendor' -g '!node_modules'",
                },
            })
            vim.keymap.set("n", "<leader>f", fzf.files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>gg", fzf.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>b", fzf.buffers, { desc = "Buffers" })
            vim.keymap.set("n", "<leader>s", fzf.lsp_document_symbols, { desc = "Document symbols" })
            vim.keymap.set("n", "<leader>S", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
            vim.keymap.set("n", "<leader>G", fzf.git_status, { desc = "Git status" })
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
            vim.keymap.set("n", "<leader>-", function() require("oil").toggle_float() end, { desc = "Toggle Oil file explorer" })
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
                    gdscript = { "gdformat" },
                },
                format_on_save = function(bufnr)
                    if vim.bo[bufnr].filetype == "gdscript" then
                        return false
                    end
                    return { timeout_ms = 500, lsp_format = "fallback" }
                end,
                format_after_save = function(bufnr)
                    if vim.bo[bufnr].filetype == "gdscript" then
                        return { lsp_format = "fallback" }
                    end
                end,
            })
        end,
    },
    {
        "sourcegraph/amp.nvim",
        branch = "main",
        lazy = false,
        opts = { auto_start = true, log_level = "info" },
    },
}, { performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } } })

vim.api.nvim_create_user_command("AmpSend", function(opts)
    local message = opts.args
    if message == "" then
        print("Please provide a message to send")
        return
    end
    require("amp.message").send_message(message)
end, { nargs = "*", desc = "Send a message to Amp" })

vim.api.nvim_create_user_command("AmpSendBuffer", function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    require("amp.message").send_message(table.concat(lines, "\n"))
end, { desc = "Send current buffer contents to Amp" })

vim.api.nvim_create_user_command("AmpPromptSelection", function(opts)
    local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
    require("amp.message").send_to_prompt(table.concat(lines, "\n"))
end, { range = true, desc = "Add selected text to Amp prompt" })

-- LSP setup using native vim.lsp.config (Neovim 0.11+)
local caps = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "Go to declaration" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "References" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf, desc = "Implementation" })
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = args.buf, desc = "Type definition" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover" })
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename" })
        vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, { buffer = args.buf, desc = "Code action" })
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = args.buf, desc = "Diagnostic float" })
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { buffer = args.buf, desc = "Prev diagnostic" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { buffer = args.buf, desc = "Next diagnostic" })

        -- Disable default grr/gri/gra/grn mappings after all LspAttach handlers run
        vim.schedule(function()
            pcall(vim.keymap.del, "n", "grr", { buffer = args.buf })
            pcall(vim.keymap.del, "n", "gri", { buffer = args.buf })
            pcall(vim.keymap.del, "n", "gra", { buffer = args.buf })
            pcall(vim.keymap.del, "n", "grn", { buffer = args.buf })
        end)
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
                    "/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin",
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
    init_options = {
        typescript = {
            tsdk = vim.fn.stdpath("data") ..
                "/mason/packages/vue-language-server/node_modules/typescript/lib",
        },
    },
    on_attach = function(client)
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.renameProvider = false
    end,
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

vim.lsp.config("gdscript", {
    cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
    filetypes = { "gdscript" },
    root_markers = { "project.godot", ".git" },
    capabilities = caps,
})

vim.lsp.enable({ "gopls", "ts_ls", "volar", "pyright", "lua_ls", "gdscript" })
