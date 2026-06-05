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
map('n', '<leader>cn', ':tabnew<CR>')
map('n', '<leader>ct', ':tabclose<CR>')
map('n', '<leader>ca', ':tabonly<CR>')


-- neo-tree keymaps
map('n', '<leader>e', ':Neotree toggle<CR>')

-- telescope keymaps
map('n', '<leader>ff', ':Telescope find_files<CR>')

-- oil keymaps
map('n', '<leader>r', ':Oil --float<CR>')


