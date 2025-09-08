-- VISUAL MODE
-- Move lines up or down.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- NORMAL MODE
-- join lines below, keeping the cursor at the beginning of the line.
vim.keymap.set("n", "J", "mzJ`z")
-- jump half page, keeping the cursor in the middle.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- keep the search term in the middle of the screen.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- after copying, use it to paste without losing the buffer.
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "q")
vim.keymap.set("n", "W", "w")

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set({ "n", "v" }, "<C-c>", function()
	vim.cmd("normal gcc")
end)

vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>5+")
vim.keymap.set("n", "<M-s>", "<C-W>5-")

-- move current line down one line.
vim.keymap.set("n", "<M-j>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! ]c]])
	else
		vim.cmd([[m .+1<CR>==]])
	end
end)

-- move current line up one line.
vim.keymap.set("n", "<M-k>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! [c]])
	else
		vim.cmd([[m .-2<CR>==]])
	end
end)

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>t", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)

-- Used by Obsidian.
-- vim.opt.conceallevel = 2

vim.keymap.set("n", "<leader>rc", function()
	vim.cmd("source $MYVIMRC")

	require("lazy").sync()

	vim.notify("nvim configuration reloaded!!", vim.log.levels.INFO, { title = "Nvim" })
end)

vim.keymap.set("n", "<leader>-", function()
	require("oil").toggle_float()
end, { desc = "Toggle Oil (open/close float window)" })

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save buffer" })
vim.keymap.set("n", "<leader>gu", function()
	-- Get the output of uuidgen and trim any trailing newline
	local uuid = vim.fn.system("uuidgen"):gsub("\n", "")
	-- Insert the UUID at the cursor position with a space before it.
	vim.api.nvim_put({ " " .. uuid }, "c", false, true)
end, { desc = "Insert UUID at cursor" })

-- Godot-specific keymaps
local function create_godot_keymap(key, cmd, desc)
	vim.keymap.set("n", key, function()
		if vim.bo.filetype == "gdscript" then
			vim.cmd("!" .. cmd)
		else
			vim.notify("This keymap only works in GDScript files", vim.log.levels.WARN)
		end
	end, { desc = desc })
end

-- Run current scene in Godot
create_godot_keymap("<leader>gy", "/opt/godot/godot --path . %", "Run current scene in Godot")
-- Run main scene in Godot
create_godot_keymap("<leader>gm", "/opt/godot/godot --verbose --path .", "Run main scene in Godot")
