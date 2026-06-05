-- gruvbox.nvim.lua
vim.pack.add({
    "https://github.com/ellisonleao/gruvbox.nvim"
})
require("gruvbox").setup({terminal_colors = true, contrast = "soft"})
vim.o.background = "light"
vim.cmd.colorscheme("gruvbox")
