-- keymaps.lua
local map = vim.keymap.set

vim.g.mapleader = " "
map('n', '<leader>o', ':update<CR> :source <CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit!<CR>')
map({'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
map('n', '<C-h>', '<C-w><Left>')
map('n', '<C-l>', '<C-w><Right>')
map('i', '<C-H>', '<C-w>', { noremap = true })
map('x', 'p', [["_dP]], { desc = "paste over selection w/o losing yy text"})
map('n', '<C-c>', ':nohl<CR>', { desc = "clear search highlighting", silent = true})
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual"})
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual"})
map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "replace word cursor"})

-- neo-tree keymaps
map('n', '<leader>e', ':Neotree toggle<CR>')

-- telescope keymaps
map('n', '<leader>ff', ':Telescope find_files<CR>')

-- fugitive keymaps
map('n', '<leader>gg', '<cmd>tabnew | Git | only<CR>', {desc = 'fugitive full page new tab'})
map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>', { desc = "git diff split"})


