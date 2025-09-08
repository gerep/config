-- Godot/GDScript specific settings
vim.o.tabstop = 4          -- A TAB character looks like 4 spaces
vim.o.expandtab = false    -- Use actual TAB characters, not spaces
vim.o.softtabstop = 4      -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4       -- Number of spaces inserted when indenting
vim.o.commentstring = "# %s" -- Comment support for GDScript
vim.o.autoindent = true    -- Maintain indentation on new lines

-- Additional Godot-specific settings
vim.opt_local.textwidth = 100  -- Godot's recommended line length
