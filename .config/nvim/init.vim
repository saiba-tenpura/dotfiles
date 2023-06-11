" Plugins
call plug#begin()
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

" Miscellanous
Plug 'mbbill/undotree'
call plug#end()

" Include lua files
lua require('saiba')

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
