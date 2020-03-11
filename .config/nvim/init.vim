" Backup
set nobackup
set noswapfile

" Colors & Fonts
set t_Co=256
" colorscheme


" Indentation
set tabstop=4
set shiftwidth=4
set expandtab
filetype indent plugin on

" UI
syntax enable
set number
set encoding=utf-8
set showmatch               " highlight matching {[()]}

" Search
set path+=**                " Search recursively in current dir
set wildmenu                " Diplay matches in tab list
set incsearch
set hlsearch
