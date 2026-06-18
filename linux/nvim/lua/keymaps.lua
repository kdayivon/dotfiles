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
map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'exit terminal mode' })

-- neo-tree keymaps
map('n', '<leader>e', ':Neotree toggle<CR>')

-- telescope keymaps
map('n', '<leader>ff', ':Telescope find_files<CR>')

-- fugitive keymaps
map('n', '<leader>gg', '<cmd>tabnew | Git | only<CR>', {desc = 'fugitive full page new tab'})
map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>', { desc = "git diff split"})

-- barbar keymaps
local opts = { noremap = true, silent = true }
map('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts, {desc = "go to previous tab"})
map('n', '<A-l>', '<Cmd>BufferNext<CR>', opts, {desc = "go to previous tab"})
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts, {desc = "close current tab"})
map('n', '<A-&>', '<Cmd>BufferGoto 1<CR>', opts, {desc = "go to 1 tab"})
map('n', '<A-é>', '<Cmd>BufferGoto 2<CR>', opts, {desc = "go to 2 tab"})
map('n', '<A-">', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-!>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-ç>', '<Cmd>BufferGoto 5<CR>', opts)

