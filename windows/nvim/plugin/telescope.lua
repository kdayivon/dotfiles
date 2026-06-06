-- telescope.lua
vim.pack.add({
    {
        src = 'https://github.com/nvim-telescope/telescope.nvim',
    },
    "https://github.com/BurntSushi/ripgrep",
    "https://github.com/sharkdp/fd",
})

require('telescope').setup{
		defaults = {
			layout_config = {
				width = 0.95,
				height = 0.85,
			},
			path_display = {
				"filename_first",
			},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--no-ignore",
				"--fixed-strings",
			},
		},
        extensions = {
           fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
           }, 
        },
		pickers = {
			find_files = {
                hidder = true,
				no_ignore_parent = true,
			},
		},
}

pcall(require('telescope').load_extension, 'fzf')


local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'telescope fzy finder' })
vim.keymap.set('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", { desc = 'telecsope file finder'}) 

