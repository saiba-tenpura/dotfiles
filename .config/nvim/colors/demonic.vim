" Vim color file
" Name:         demonic.vim
" Maintainer:	Ayn Soph <aynsoph@aynsoph.dev>

set background=dark

highlight clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name="demonic"

" Editor settings
hi Normal       ctermfg=white
hi Cursor       ctermfg=none ctermbg=none
hi CursorLine   ctermbg=none cterm=none
hi LineNr       ctermfg=darkred
hi CursorLineNR ctermfg=red cterm=bold

" File Navigation / Searching
hi Directory    ctermfg=darkblue
hi Search       ctermfg=white ctermbg=darkred
hi IncSearch    ctermfg=white ctermbg=red

" Prompt/Status
hi StatusLine   ctermfg=white ctermbg=lightgrey
hi StatusLineNC ctermfg=none ctermbg=none
hi WildMenu     ctermfg=white ctermbg=darkred
hi Question     ctermfg=white ctermbg=blue
hi Title        ctermfg=none ctermbg=none
hi ModeMsg      ctermfg=darkred ctermbg=none
hi MoreMsg      ctermfg=darkblue ctermbg=none

" Visual aid
hi ErrorMsg     ctermfg=white ctermbg=darkred
hi WarningMsg   ctermfg=white ctermbg=darkyellow

" Syntax Highlighting
hi Comment      ctermfg=darkgrey
hi Constant     ctermfg=red
hi Identifier   ctermfg=69 cterm=none
hi Statement    ctermfg=yellow
hi PreProc      ctermfg=magenta
hi Type         ctermfg=75
hi Special      ctermfg=lightmagenta
