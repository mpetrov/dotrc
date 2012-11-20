" Vim color file
" Original Maintainer:  Lars H. Nielsen (dengmao@gmail.com)
" Last Change:  2010-07-23
"
" Converting for 256-color terminals by
" Danila Bespalov (danila.bespalov@gmail.com)
" with great help of tool by Wolfgang Frisch (xororand@frexx.de)
" inspired by David Liang's version (bmdavll@gmail.com)

set background=dark

hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "wombat256"


" General colors
hi Normal		ctermfg=254		ctermbg=234		cterm=none		guifg=#f6f3e8	guibg=#242424	gui=none
hi Cursor		ctermfg=none	ctermbg=241		cterm=none		guifg=NONE		guibg=#656565	gui=none
hi Visual		ctermfg=7		ctermbg=238		cterm=none		guifg=#f6f3e8	guibg=#444444	gui=none
" hi VisualNOS
" hi Search
hi Folded		ctermfg=103		ctermbg=238		cterm=none		guifg=#a0a8b0	guibg=#384048	gui=none
hi Title		ctermfg=7		ctermbg=none	cterm=bold		guifg=#f6f3e8	guibg=NONE		gui=bold
hi StatusLine	ctermfg=7		ctermbg=238		cterm=none		guifg=#f6f3e8	guibg=#444444	gui=italic
hi VertSplit	ctermfg=238		ctermbg=238		cterm=none		guifg=#444444	guibg=#444444	gui=none
hi StatusLineNC	ctermfg=243		ctermbg=238		cterm=none		guifg=#857b6f	guibg=#444444	gui=none
hi LineNr		ctermfg=243		ctermbg=0		cterm=none		guifg=#857b6f	guibg=#000000	gui=none
hi SpecialKey	ctermfg=244		ctermbg=236		cterm=none		guifg=#808080	guibg=#343434	gui=none
hi NonText		ctermfg=244		ctermbg=236		cterm=none		guifg=#808080	guibg=#303030	gui=none

" Vim >= 7.0 specific colors
if version >= 700
hi CursorLine					ctermbg=236		cterm=none						guibg=#2d2d2d
hi MatchParen	ctermfg=7		ctermbg=243		cterm=bold		guifg=#f6f3e8	guibg=#857b6f	gui=bold
hi Pmenu		ctermfg=7		ctermbg=238						guifg=#f6f3e8	guibg=#444444
hi PmenuSel		ctermfg=0		ctermbg=192						guifg=#000000	guibg=#cae682
endif


highlight DiffAdd term=reverse cterm=bold ctermbg=22 ctermfg=white
highlight DiffChange term=reverse cterm=none ctermbg=52 ctermfg=white
highlight DiffText term=reverse cterm=none ctermbg=130 ctermfg=white
highlight DiffDelete term=reverse cterm=none ctermbg=18 ctermfg=white

hi TabLineFill ctermbg=237 cterm=none term=reverse
hi TabLineSel ctermbg=32 cterm=bold ctermfg=17
hi TabLine ctermbg=237 cterm=none



" Syntax highlighting
hi Keyword		ctermfg=111		cterm=none		guifg=#8ac6f2	gui=none
hi Statement	ctermfg=111		cterm=none		guifg=#8ac6f2	gui=none
hi Constant		ctermfg=173		cterm=none		guifg=#e5786d	gui=none
hi Number		ctermfg=173		cterm=none		guifg=#e5786d	gui=none
hi PreProc		ctermfg=173		cterm=none		guifg=#e5786d	gui=none
hi Function		ctermfg=192		cterm=none		guifg=#cae682	gui=none
hi Identifier	ctermfg=192		cterm=none		guifg=#cae682	gui=none
hi Type			ctermfg=192		cterm=none		guifg=#cae682	gui=none
hi Special		ctermfg=194		cterm=none		guifg=#e7f6da	gui=none
hi String		ctermfg=113		cterm=none		guifg=#95e454	gui=italic
hi Comment		ctermfg=246		cterm=none		guifg=#99968b	gui=italic
hi Todo			ctermfg=245		cterm=none		guifg=#8f8f8f	gui=italic

if !has('gui_running')
	hi Error			ctermfg=52		cterm=none		guifg=#5f0000	gui=italic
	hi SpellBad			ctermfg=52		cterm=none		guifg=#5f0000	gui=italic
	hi SpellLocal			ctermfg=17		cterm=none		guifg=#00005f	gui=italic
	hi SpellCap			ctermfg=17		cterm=none		guifg=#00005f	gui=italic
endif

" Links
hi! link FoldColumn		Folded
hi! link CursorColumn	CursorLine


if v:version >= 703
  hi ColorColumn ctermbg=236 cterm=none guibg=#2d2d2d
endif
" vim:set ts=4 sw=4 noet:
