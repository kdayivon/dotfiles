-- iron.lua
vim.pack.add({
    {
        src = 'https://github.com/hkupty/iron.nvim',
    }
})
 

local iron = require("iron.core")
local view = require("iron.view")
iron.setup({
    config = {
        repl_open_cmd = view.split.vertical.rightbelow("%40"),

        repl_definition = {
            julia = {
                command = { "C:/Users/Elysian/AppData/Local/Programs/Julia-1.12.6/bin/julia.exe" },
            },
        },
    },
    keymaps = {
        toggle_repl = "<space>rp",
        send_line = "<leader>sl",
        visual_send = "<leader>sv",
        send_file = "<leader>sf",
        clear = "<leader>sc",
        exit = "<leader>sq",
    }
})

vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<CR>', { desc = 'focus repl'})
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<CR>', { desc = 'hide repl'})



