"========================================================
" Terminal settings
filetype off
filetype plugin indent on    " required

" Set the terminal title
set title

" Use vim not vi
set nocompatible

" Use my color preferences
set background=dark
colorscheme markus

" Use syntax colors
syntax enable

" Set terminal colors
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
set modelines=5
set t_Co=256

" Set tab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Use UTF-8
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" Automatically write buffer before special actions
set autowrite

" Command line history
set history=1000

" Highlight matches
set hlsearch

" Set statusline
set statusline=%F%m%r%h%w\ %y\ [pos=%l,%v]\ [len=%L\ (%p%%)]

" Don't move cursor to first line when scrolling
set nostartofline

" Want mouse support
set mouse=a

" Maintain some more context around the cursor
set scrolloff=3
set sidescrolloff=3

" Show line numbers
set number

" Don't wrap words
set textwidth=0

" Set width of number
set numberwidth=4

" Set size of window
set columns=135
set lines=50
winpo 620 45


" ========================================================
" Leader settings

" Ex-mode is pretty dumb, remap Q to reformat the current paragraph
nnoremap Q gqip

" Function key settings - 'make'-shortcuts
map <F5> :cp<CR>
map <F6> :cn<CR>
" Have <F2> toggle paste
set pastetoggle=<F2>

" Have <F3> toggle spelling mode
nmap <F3> :setlocal invspell spelllang=en_us<CR>

" , is a more convenient leader than \
let maplocalleader = ",,"
let mapleader = ","

" Underline the current line with - in normal mode
nnoremap <leader>u yyp<c-v>$r-

" Underline the current line with = in normal mode
nnoremap <leader>U yyp<c-v>$r=

" OCaml stuff
let no_ocaml_comments = 1
set makeprg=ocamlbuild\ ${BUILDFLAGS}\ -use-ocamlfind\ all.otarget
"set makeprg=omake\ -j\ 8

" Tex stuff
" Please refer to:
" http://vim-latex.sourceforge.net/index.php?subject=download&title=Download
"
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Remove GUI-nonsense
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Always show the menu, insert longest match
set completeopt=menu,longest

" Ignore irrelevant suffixes for filename completion
set wildignore+=*.a,*.bak,*~,*.swp,*.o,*.info,*.aux,*.dvi,*.bbl,*.blg,*.brf,*.cb,*.ind,*.idx,*.ilg,*.inx,*.out,*.toc,*.cmi,*.cmo,*.cma,*.cmx,*.cmxa,$.cmxs,*.omc,*.annot,*.exe,*.native,*.byte,*.bc,*.sums,*.spit,*.spot

" Change directories automatically
autocmd BufEnter * lcd %:p:h

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Our shell code looks like a scheme programmer made up all the names
autocmd FileType sh set iskeyword=~,@,48-57,_,192-255,-

" Set location for NetrW bookmarks and history
let g:netrw_home=$HOME

" Syntastic
" let g:syntastic_ocaml_use_ocamlc = 1
let g:syntastic_ocaml_use_ocamlbuild = 1
let g:syntastic_ocaml_checkers = ['merlin']

" Currently disabled
" let g:pathogen_disabled = ['syntastic', 'ocamlmerlin']
set ofu=syntaxcomplete#Complete

" Load Pathogen
call pathogen#infect()

" Load matchit
runtime! macros/matchit.vim

" SnipMate stuff
let g:snips_author = 'Zhang Lei'

" MRU-functionality
nnoremap <leader>m :MRU<CR>

" FuF-functionality
nnoremap <leader>ff :FufFile<CR>
nnoremap <leader>fd :FufDir<CR>
nnoremap <leader>fb :FufBuffer<CR>
nnoremap <leader>fC :FufCoverageFile<CR>
nnoremap <leader>fl :FufLine<CR>
nnoremap <leader>fj :FufJumpList<CR>
nnoremap <leader>fc :FufChangeList<CR>

" Make
nnoremap <leader>M :make<CR>

" Turn off match highlighting
nnoremap <leader>h :nohlsearch<CR>

" Save quickly
nnoremap <leader>w :w<CR>

" ocp-indent - handled in "after/indent" now
" autocmd FileType ocaml source ~/.opam/4.01.1/share/typerex/ocp-indent/ocp-indent.vim

if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif


"========================================================
" Plugin Settings
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
" Install plugins
Bundle 'fatih/vim-go'
Bundle 'Pydiction'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/powerline'
Bundle 'tpope/vim-fugitive'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'

"Set NERDTree
map <C-o> :NERDTreeToggle<CR>
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='.a:bg.' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd filetype nerdtree syn match ' . a:extension .'#^\s\+.*'.a:extension .'$#'
endfunction

"Set ctrlpvim
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <Leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

"Set ctrlpfunky
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']
