return {
    "lewis6991/gitsigns.nvim",
    version = "v1.0.2",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signs_staged = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                -- Actions
                map("n", "<leader>gsh", gs.stage_hunk)
                map("n", "<leader>grh", gs.reset_hunk)
                map("v", "<leader>gsh", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)
                map("v", "<leader>grh", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)
                map("n", "<leader>gsb", gs.stage_buffer)
                map("n", "<leader>gu", gs.undo_stage_hunk)
                map("n", "<leader>grb", gs.reset_buffer)
                map("n", "<leader>gp", gs.preview_hunk)
                map("n", "<leader>gb", function()
                    gs.blame_line({ full = true })
                end)
                map("n", "<leader>tb", gs.toggle_current_line_blame)
                map("n", "<leader>gd", gs.diffthis)
                map("n", "<leader>gD", function()
                    gs.diffthis("~")
                end)
                map("n", "<leader>td", gs.toggle_deleted)

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        })
    end,
}
