-- Neovim Keymaps Configuration

vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

vim.g.mapleader = " "
-- File Explorer (nvim-tree)
vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in explorer" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- LSP Keybindings (global)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Signature help" })
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, { desc = "Code action" })

-- Alternative LSP navigation using Telescope (when gd fails)
vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", { desc = "LSP: Find definitions" })
vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP: Find references" })
vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP: Find implementations" })
vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "LSP: Document symbols" })
vim.keymap.set("n", "<leader>lw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "LSP: Workspace symbols" })
vim.keymap.set("n", "<leader>lf", function()
    require('telescope.builtin').lsp_dynamic_workspace_symbols({
        default_text = vim.fn.expand('<cword>')
    })
end, { desc = "LSP: Find current word in workspace" })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
