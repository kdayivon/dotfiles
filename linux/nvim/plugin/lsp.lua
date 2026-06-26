-- lsp.lua
vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/JuliaEditorSupport/julia-vim" },
    { src = "https://github.com/mfussenegger/nvim-jdtls" },
})

vim.cmd("packadd blink.cmp")
vim.cmd("packadd blink.lib")
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- java
local jdtls = require("jdtls")

local root_dir = require("jdtls.setup").find_root({
    ".git", "mvnw", "gradlew", "pom.xml"
})

if not root_dir then return end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/" .. project_name

jdtls.start_or_attach({
    cmd = { vim.fn.expand("~/.local/share/jdtls/bin/jdtls"), "-data", workspace_dir }, root_dir = root_dir,
    capabilities = capabilities,
})

-- julia
vim.lsp.config("julials", {
    capabilities = capabilities,
})
vim.lsp.enable("julials")


