-- opts.lua
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10

vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")

-- wezterm window padding
local function set_user_var(name, value)
  if vim.env.TERM_PROGRAM == 'WezTerm' or os.getenv('TERM'):find('wezterm') then
    io.write(string.format('\027]1337;SetUserVar=%s=%s\027\\', name, vim.base64.encode(value)))
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function() set_user_var('IN_NEOVIM', '1') end,
})

vim.api.nvim_create_autocmd('VimLeave', {
  callback = function() set_user_var('IN_NEOVIM', '0') end,
})
