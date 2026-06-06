-- lsp.lua
vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/JuliaEditorSupport/julia-vim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/mfussenegger/nvim-jdtls" },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- java
local jdtls = require("jdtls")
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" })
if not root_dir then return end
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local worspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name  
local jdtls_path = vim.fn.expand("C:/tools/jdtls")
local cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Xmx1G",
    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", jdtls_path .. "/config_win",
    "-data", workspace_dir,
}

jdtls.start_or_attach({
    cmd = cmd,
    root_dir = root_dir,
})

-- julia
vim.lsp.config("julials", {
    capabilities = capabilities,
})
vim.lsp.enable("julials")


