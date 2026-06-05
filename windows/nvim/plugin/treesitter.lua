-- treesitter.lua
vim.pack.add({
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        branch = 'main',
    }
})

require('nvim-treesitter') 
local treesitter = require('nvim-treesitter')
local ensure_installed = {
    "c", "cpp", "bash", "csv", "java", "julia", "python", 
}
treesitter.install(ensure_installed)
