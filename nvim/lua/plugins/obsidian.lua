return {
    {
        'epwalsh/obsidian.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local obsidian = require('obsidian')
            -- Setup with workspace configuration
            obsidian.setup({
                workspaces = {
                    {
                        name = "notes",
                        path = "/home/daniel/notes",
                    },
                },
                -- Additional recommended settings
                completion = {
                    nvim_cmp = true,
                    min_chars = 2,
                },
                mappings = {},
                note_id_func = function(title)
                    -- Create note IDs in a Zettelkasten format
                    local suffix = ""
                    if title ~= nil then
                        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                    else
                        suffix = os.time()
                    end
                    return tostring(suffix)
                end,
            })

            -- Telescope integration for finding files
            vim.keymap.set('n', '<leader>of', function()
                require('telescope.builtin').find_files({
                    cwd = "/home/daniel/notes",
                    prompt_title = "󰍩 Obsidian Vault",
                })
            end, { desc = '[O]bsidian [F]ind File' })

            -- Telescope integration for live grep
            vim.keymap.set('n', '<leader>og', function()
                require('telescope.builtin').live_grep({
                    cwd = "/home/daniel/notes",
                    prompt_title = "󰍩 Obsidian Grep",
                })
            end, { desc = '[O]bsidian [G]rep' })

            -- Follow link under cursor
            vim.keymap.set('n', 'gf', function()
                if obsidian.util.cursor_on_markdown_link() then
                    return '<cmd>ObsidianFollowLink<CR>'
                else
                    return 'gf'
                end
            end, { noremap = false, expr = true })
            vim.keymap.set('n', '<leader>on', function()
                vim.ui.input({ prompt = "Note Title: " }, function(title)
                    if title == nil or title == "" then
                        return
                    end

                    vim.cmd("ObsidianNew " .. title)
                end)
            end, { desc = '[O]bsidian [N]ew Note' })
        end,
    },
}
