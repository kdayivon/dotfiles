-- barbar.lua   
vim.pack.add({
    { src = 'https://github.com/nvim-tree/nvim-web-devicons', lazy = false },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/romgrk/barbar.nvim' },
})

vim.g.barbar_auto_setup = false
require('barbar').setup({
    
})

