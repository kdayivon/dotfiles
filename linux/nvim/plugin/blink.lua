vim.pack.add({
  { src = "https://github.com/saghen/blink.lib", version = vim.version.range("v1.*") },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("v1.*") },
  "https://github.com/rafamadriz/friendly-snippets"
})


local cmp = require("blink.cmp")
cmp.setup({
  keymap = {
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<CR>"]  = { "accept", "fallback" },
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
  },

    appearance = {
       use_nvim_cmp_as_default = true,
       nerd_font_variant = 'mono'
    },

    signature = { enabled = true }
})
