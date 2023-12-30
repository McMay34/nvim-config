set number
set mouse=a

set termguicolors
set relativenumber
let mapleader=" "

filetype plugin indent on

nnoremap <leader>n <cmd>NvimTreeToggle<cr>
inoremap ii <esc>

call plug#begin()

Plug 'lervag/vimtex'

Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
" Plug 'preservim/nerdtree'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ap/vim-css-color'
" Plug 'ryanoasis/vim-devicons'

" Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'lewis6991/gitsigns.nvim'

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

"lua << EOF
" require("bufferline").setup{}
" EOF

lua << EOF
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

require("gitsigns").setup()
-- OR setup with some options
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
EOF

let g:airline_powerline_fonts = 1

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

colorscheme gruvbox


syntax enable


