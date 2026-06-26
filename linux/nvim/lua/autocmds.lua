-- autocmds.lua
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.tex",
    callback = function()
        local template = vim.fn.stdpath("config") .. "/templates/latex.tex"

        if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
            vim.cmd("0r " .. template)
            vim.cmd("normal! G")
        end
    end,
})
