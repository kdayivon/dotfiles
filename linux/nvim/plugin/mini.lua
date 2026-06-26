-- mini.lua
vim.pack.add({
    {
        src = 'https://github.com/nvim-mini/mini.nvim',
    }
})

-- mini file explorer
local MiniFiles = require("mini.files")
MiniFiles.setup({
    mappings = {
        go_in_plus = "l",
    }
})
vim.keymap.set('n', '<leader>r', function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
end, { desc = "toggle currently opened file in mini" })

-- mini notify
require("mini.notify").setup({
    content = {
        format = function(notif)
            return notif.msg
        end,
    }
})

-- mini cmdline helper
require("mini.cmdline").setup({
    autocorrect = { enable = false }
})

-- mini surround 
require("mini.surround").setup()

-- mini extra - keymaps doc
local MiniExtra = require("mini.extra")
MiniExtra.setup()

vim.keymap.set('n', '<leader>pk', function() MiniExtra.pickers.keymaps() end, { desc = 'search keymaps' })


-- mini diff - git
local MiniDiff = require("mini.diff")
MiniDiff.setup({
    source = MiniDiff.gen_source.git({index = false}),
})

