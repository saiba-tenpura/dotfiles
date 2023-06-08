" vim plugins
call plug#begin('~/.local/share/nvim/plugged')
" Color preview
Plug 'ap/vim-css-color'

" Lua function library (required by telescope)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.1'}

" Extendable fuzzy finder
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'}
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
call plug#end()

" Include lua files
lua require('saiba')

" Backup
set nobackup
set noswapfile

" Clipboard
set clipboard=unnamedplus

" Colors & Fonts
set t_Co=256

" Custom key bindings
" move lines with Ctrl + J/K
nnoremap <C-j> :m +1<cr>
nnoremap <C-k> :m -2<cr>
inoremap <C-j> <Esc>:m +1<cr>gi
inoremap <C-k> <Esc>:m -2<cr>gi
vnoremap <C-j> :m '>+1<cr>gvgv
vnoremap <C-k> :m '<-2<cr>gvgv

" Telescope shortcuts
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>lg <cmd>Telescope live_grep<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>

" Indentation
filetype indent plugin on
set tabstop=4
set shiftwidth=4
set expandtab

" UI
syntax enable
set number
set encoding=utf-8
set showmatch               " highlight matching {[()]}
set noshowmode              " Don"t show vim mode

" Search
set hlsearch
set incsearch
set path+=**                " Search recursively in current dir
set wildmenu                " Diplay matches in tab list

set wildignore+=.git,.hg,.svn
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb

" Splits
set splitbelow
set splitright

" Styling

" Statusline
" :h mode() to see all modes
let g:currentmode = {
    \ "n"      : "NORMAL ",
    \ "no"     : "N⋅OPERATOR PENDING ",
    \ "v"      : "VISUAL ",
    \ "V"      : "V⋅LINE ",
    \ "\<C-V>" : "V⋅BLOCK ",
    \ "s"      : "SELECT ",
    \ "S"      : "S⋅LINE ",
    \ "\<C-S>" : "S⋅BLOCK ",
    \ "i"      : "INSERT ",
    \ "R"      : "REPLACE ",
    \ "Rv"     : "V⋅REPLACE ",
    \ "c"      : "COMMAND ",
    \ "cv"     : "VIM EX ",
    \ "ce"     : "EX ",
    \ "r"      : "PROMPT ",
    \ "rm"     : "MORE ",
    \ "r?"     : "CONFIRM ",
    \ "!"      : "SHELL ",
    \ "t"      : "TERMINAL "
\}

set laststatus=2
hi User1 ctermfg=white ctermbg=darkred
hi User2 ctermfg=lightgray ctermbg=234

set statusline=
set statusline+=%<                                   " Truncate line
set statusline+=%1*
set statusline+=\ %{g:currentmode[mode()]}           " Current mode
set statusline+=%2*
set statusline+=\ %f                                 " Relative path
set statusline+=\ %h%m%r                             " Help, modifiable, readonly
set statusline+=\ %=                                 " Shift to right-side
set statusline+=%2*
set statusline+=\ %y                                 " Filetype
set statusline+=\ %{(&fenc!=''?&fenc:&enc)}\ %{&ff}  " File encoding
set statusline+=\ %1*
set statusline+=\ %l:%c                              " Line & Column
set statusline+=\ %P                                 " Percentage
set statusline+=\ %*

" Highlights
hi! link SignColumn Normal

" Autocomplete menu
hi PMenu ctermfg=lightgray ctermbg=234

