-- lualine.lua
vim.pack.add({
    'https://github.com/nvim-lualine/lualine.nvim'
})

local theme = require('lualine.themes.gruvbox-material')
require('lualine').setup({ options = { theme = theme }})
