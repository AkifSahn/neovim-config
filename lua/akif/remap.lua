vim.g.mapleader = " "

vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "<leader>te", function()
    vim.cmd(":Texplore")
end)

-- alternate file
vim.keymap.set("n", "^", "<C-^>")

-- navigate between tabs
vim.keymap.set("n", "<M-l>", "gt")
vim.keymap.set("n", "<M-h>", "gT")
vim.keymap.set("n", "<M-q>", "1gt")
vim.keymap.set("n", "<M-w>", "2gt")
vim.keymap.set("n", "<M-e>", "3gt")
vim.keymap.set("n", "<M-r>", "4gt")
vim.keymap.set("n", "<M-t>", "5gt")

-- resizing windows
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<Up>", ":resize -2<CR>")
vim.keymap.set("n", "<Down>", ":resize +2<CR>")

-- moving blocks in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

-- System clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Open split vindow
vim.keymap.set("n", "<leader>v", ":vsplit <CR>")

-- quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- format
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- rename
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Man pages shortcut
vim.keymap.set("n", "m", ":Man ")
vim.keymap.set("n", "<leader>m", ":Man <C-r><C-w>")

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)
