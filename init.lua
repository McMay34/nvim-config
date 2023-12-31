vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.mouse = "a"

vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.g.mapleader = " "

-- filetype plugin indent on

vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("i", "ii", "<esc>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

	'lervag/vimtex',

	'SirVer/ultisnips',
	{
	    'nvim-lualine/lualine.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = true
	},
	'rafi/awesome-vim-colorschemes',
	'ap/vim-css-color', -- Previewed die Farbe von Farben in css files
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = 'nvim-tree/nvim-web-devicons'
	},

	'lewis6991/gitsigns.nvim',
	'tpope/vim-surround',

	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = 'nvim-tree/nvim-web-devicons',
		event = "BufReadPre",
		opts = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
					}
				}
			}
		}
	},
	"neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
}

require("lazy").setup(plugins)

-- autocmds
vim.api.nvim_create_autocmd("FileType", { command = "setlocal shiftwidth=4 tabstop=4 softtabstop=4", pattern = { "lua", "rust", "python" } } )




-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


require("gitsigns").setup()
require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})

vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0

-- vim.cmd("colorscheme gruvbox")
vim.cmd("colorscheme sonokai")


-- syntax enable

require("maessju.lspconfig")
