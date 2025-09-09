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
vim.keymap.set("n", "<leader>ln", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>lp", "<cmd>lprev<CR>zz")

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Quick exit insert mode
vim.keymap.set("i", "jk", "<Esc>")

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

vim.keymap.set("n", "<leader>gm", function()
	-- Build the shell command: cd … && make genlastmodall
	local cmd =
		string.format("cd %s && make genlastmodall", vim.fn.shellescape("/home/daniel/bootdev/go-api-gate/courses"))
	-- Execute it and show the output in the command line
	vim.cmd("!" .. cmd)
end, { desc = "Run make genlastmodall in project folder" })
