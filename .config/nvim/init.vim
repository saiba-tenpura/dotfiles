" vim plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'ap/vim-css-color'     " Color preview
call plug#end()

" Backup
set nobackup
set noswapfile

" Colors & Fonts
set t_Co=256

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
hi User2 ctermfg=lightgrey ctermbg=234
hi User3 ctermfg=lightgrey ctermbg=8

set statusline=
set statusline+=%<                                   " Truncate line
set statusline+=%1*
set statusline+=\ %{g:currentmode[mode()]}           " Current mode
set statusline+=%2*
set statusline+=\ %f                                 " Relative path
set statusline+=\ %h%m%r                             " Help, modifiable, readonly
set statusline+=%3*
set statusline+=\ %=                                 " Shift to right-side
set statusline+=%2*
set statusline+=\ %y                                 " Filetype
set statusline+=\ %{(&fenc!=''?&fenc:&enc)}\ %{&ff}  " File encoding
set statusline+=\ %1*
set statusline+=\ %l:%c                              " Line & Column
set statusline+=\ %P                                 " Percentage
set statusline+=\ %*
