-- vimtex.lua
vim.pack.add({
    {
        src = 'https://github.com/lervag/vimtex'
    }
})

vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = "SumatraPDF"
vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
vim.g.vimtex_compiler_method = "latexmk"


