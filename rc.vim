" Set some plugin preferences {{{1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn\|\.git5_specs$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'blaze-bin\|blaze-genfiles\|blaze-google3\|blaze-out\|blaze-testlogs\|READONLY$',
  \ }
let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols_override = {'BRANCH': '', 'LINE': ''}
let g:Powerline_dividers_override = ['', '|', '', '']
let g:SuperTabMappingBackward = '<c-s-tab>'
let g:SuperTabDefaultCompletionType = '<C-N>'

" Bootstrap and load Vundle plugins {{{1
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-pastie'
Bundle 'tpope/vim-unimpaired'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/tComment'
Bundle 'ZoomWin'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mileszs/ack.vim'
Bundle 'garyharan/vim-proto'
Bundle 'vim-scripts/keepcase.vim'
Bundle 'sjl/vitality.vim'
Bundle 'sjl/gundo.vim'
Bundle 'guns/xterm-color-table.vim'
Bundle 'git@github.com:mpetrov/vim-ctrlp-related.git'
Bundle 'git@github.com:mpetrov/vim-diffstat.git'
filetype plugin indent on

" Aesthetics{{{1
" MacVIM / GVim settings {{{2
if has('gui_running')
  set guioptions=egmt
endif

" If we're using MacVim
if has('gui_macvim')
  set guifont=Menlo:h11
  set transparency=0
endif

" Assume a 256 colour terminal, make it pretty {{{2
set background=dark t_Co=256
syntax on
colorscheme wombat256
execute "set listchars=tab:" . nr2char(187) . '\ '
set ruler nu hls
set showcmd noerrorbells list wildmenu

" General Settings  {{{1

" Encoding and file preferences
set encoding=utf8 fileformats=unix,dos,mac

" Status and command settings
set laststatus=2 history=1000

" Undo and backup settings
set undofile undodir=~/.vim/undodir undolevels=1000 undoreload=10000
set nobackup nowritebackup noswapfile

" Spelling options
set spelllang=en_gb nospell

" Menu options
set backspace=indent,eol,start
set wildmode=list:longest,full

" Enable the mouse
set mouse=a

" CTags files
set tags=./tags,tags
runtime! macros/matchit.vim

" Ignore some files when using ctrl-p
set wildignore+=*.o,*.obj,.git,*.pdf,*.png,*.jpg,*.tiff,*.pyc,gen,bin,*.class,*~,*.Po,*.git5_specs

" Fold options
set foldmethod=indent foldnestmax=10
set foldenable foldlevelstart=1

" Hide the eclim sratch window
set completeopt-=preview

" Custom commands {{{2
cmap w!! w !sudo tee % >/dev/null

" Indentation and tabbing {{{2
set autoindent smartindent cindent
function! s:IndentLevel(num)
  execute 'setlocal softtabstop=' . a:num . ' shiftwidth=' . a:num . ' expandtab'
endfunction
command! -nargs=* -bar IndentLevel call s:IndentLevel(<f-args>)
IndentLevel 2

set textwidth=80

" Share the clipboard and use colorcolumn on vim 7.3 {{{2
if v:version >= 703
  set colorcolumn=+1
  hi ColorColumn ctermbg=236 cterm=none guibg=#2d2d2d
  set clipboard+=unnamed
endif

" Keyboard mappings {{{1
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>R :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
nnoremap <Leader>l "qyiwgv:s/\<<C-r>q\>//g<Left><Left>
nnoremap <Leader>L "qyiwgv:s/\<<C-r>q\>/<C-r>q/g<Left><Left>
nnoremap <Leader>a "ayiw:Ack <C-r>a<CR>

noremap <silent> <leader>- :<C-U>exe ":res -".(10 * v:count1)<CR>
noremap <silent> <leader>+ :<C-U>exe ":res +".(10 * v:count1)<CR>
noremap <silent> <leader>< :<C-U>exe ":vertical res -".(10 * v:count1)<CR>
noremap <silent> <leader>> :<C-U>exe ":vertical res +".(10 * v:count1)<CR>

noremap <silent> <leader>s :set spell!<CR>
noremap <silent> <leader>p :set paste!<CR>
noremap <silent> <leader>h :set hls!<CR>
noremap <silent> <leader>m :w<ENTER>:make<CR>

noremap <leader>d :DiffStat HEAD HEAD..HEAD~1 HEAD~1..HEAD~2<cr>

nnoremap <Leader>cc :CtrlPClearAllCaches<CR>:CtrlP<CR>
noremap <leader>b :CtrlPBuffer<cr>
noremap <leader>t :CtrlPMRU<cr>
noremap <C-h> :CtrlPMRU<cr>

" Indentation key mappings {{{2
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv
nmap <M-[> <<
nmap <M-]> >>
vmap <M-[> <gv
vmap <M-]> >gv

" File specific settings / local mappings {{{1

" Change the local leader key
let maplocalleader=","

" Define some mappings and indentation for Java
function! s:JavaBufferSettings()
  IndentLevel 2
  setlocal textwidth=100

  " Eclim bindings
  nnoremap <buffer> <LocalLeader>r :JavaRename
  nnoremap <buffer> <LocalLeader>c :JavaCorrect<CR>
  nnoremap <buffer> <LocalLeader>con :JavaConstructor<CR>
  nnoremap <buffer> <LocalLeader>gs :JavaGetSet<CR>
  nnoremap <buffer> <LocalLeader>g :JavaGet<CR>
  nnoremap <buffer> <LocalLeader>s :JavaSet<CR>
  nnoremap <buffer> <LocalLeader>ic :JavaImportClean<CR>
  nnoremap <buffer> <LocalLeader>im :JavaImportMissing<CR>
  nnoremap <buffer> <LocalLeader>pp :ProjectProblems<CR>
endfunction

augroup mpetrovgroup
  autocmd!

  " Some file-specific indentation rules
  au BufRead,BufNewFile Makefile* set noexpandtab
  au BufRead,BufNewFile *.c IndentLevel 4
  au BufRead,BufNewFile *.cc IndentLevel 4
  au BufRead,BufNewFile *.h IndentLevel 4
  au BufRead,BufNewFile *.tex  setlocal iskeyword+=_
  au BufRead,BufNewFile BUILD setlocal ft=python
  au FileType python setlocal omnifunc=pythoncomplete#Complete
  au FileType c setlocal omnifunc=ccomplete#Complete
  au FileType java call s:JavaBufferSettings()

  " Use markers to fold in vim and zsh files
  autocmd FileType vim setlocal foldmethod=marker foldlevel=0
  autocmd FileType zsh setlocal foldmethod=marker foldlevel=0

  " Open the buffer in the same spot
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" Google specific stuff goes here {{{1
let g:google_vimrc = expand("~/.google_rc/google_rc.vim")
if filereadable(g:google_vimrc) && system('uname') =~? 'linux'
  exec "source " . g:google_vimrc
end
