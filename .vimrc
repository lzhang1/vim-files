"========================================================
"" 显示相关
"========================================================
" 开启文件探测、插件及缩进
filetype plugin indent on 

" 不兼容模式
set nocompatible

set cursorline

" 设置颜色方案
set background=dark

" 语法高亮
syntax enable

" 设置tab宽度为4
set tabstop=4

" 统一缩进为4
set shiftwidth=4
set softtabstop=4
set expandtab

" 设置字符编码方式
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" 自动保存
set autowrite

" 历史记录数
set history=1000

" 搜索匹配项高亮显示
set hlsearch

" 搜索忽略大小写
set ignorecase

" 设置状态行 
set statusline=%F%m%r%h%w\ %y\ [pos=%l,%v]\ [len=%L\ (%p%%)]
set laststatus=2

" 滚动时光标不移动到行首
set nostartofline

" 支持鼠标
set mouse=a
" 
" Maintain some more context around the cursor
set scrolloff=999
set sidescrolloff=999

" 显示行号
set number

" Don't wrap words
set textwidth=0

" 行号宽度为4
set numberwidth=4

" 自动重新读入
set autoread

" 设置窗口
" set columns=120
" set lines=40
" winpo 620 45

" 设置折叠
set foldenable
set foldmethod=manual
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>


" ========================================================
"" Gvim设置
" ========================================================
let g:tex_flavor='latex'
if has("gui running")
    let g:isGUI = 1 
else
    let g:isGUI = 0
endif
" Remove GUI-nonsense
if g:isGUI
    winpos 100 10
    set lines=38 columns=120
    set guifont=Monospace\ 11
    colorscheme markus
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
endif

" ========================================================
"" 创建文件相关
" ========================================================
" Add file head
au BufRead,BufNewFile *.sh setfiletype sh
au BufRead,BufNewFile *.py setfiletype python
autocmd BufNewFile *.py,*.sh exec ":call SetTitle()" 
func SetTitle() 
    if &filetype == 'python'
        call setline(1,"\#!/usr/bin/env python") 
        call append(line("."), "\# -*- coding: utf-8 -*-")
        call append(line(".")+1, "") 
    else
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "")
    endif
    autocmd BufNewFile * normal G
endfunc

" ========================================================
"" 快捷键设置
" ========================================================

" 设置leader
let maplocalleader = ",,"
let mapleader = ","

" 快速保存
nnoremap <leader>w :w!<CR>

" 进入V模式
nnoremap <leader><leader> V


" Normal模式下,添加'---'线
nnoremap <leader>u yyp<c-v>$r-

" Normal模式下,添加'==='线
nnoremap <leader>U yyp<c-v>$r=

" 定位到最近一次cursor位置
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" MRU-functionality
"
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

" Expand region
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

"========================================================
"" 插件管理 Vundle
"========================================================
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
" Install plugins
Bundle 'fatih/vim-go'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/powerline'
Bundle 'tpope/vim-fugitive'
" NERDTree Setting
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeWinPos='left'
let NERDTreeWinSize=30
"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='.a:bg.' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"exec 'autocmd filetype nerdtree syn match ' . a:extension .'#^\s\+.*'.a:extension .'$#'
"endfunction

" Ctrlpvim Setting
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <Leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height= 15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" Ctrlpfunky Setting
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']

" Tagbar Setting
nmap <Leader>tb :TagbarToggle<CR>   
let g:tagbar_ctags_bin="~/.vim/ctags"
let g:tagbar_width = 20     
let g:tagbar_left = 1
let NERDTreeIgnore=['\.pyc', '\.pyo', '\.swp', '\~']

" Vim airline Setting
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2

"========================================================
"" 其他插件
"========================================================
" SnipMate stuff
let g:snips_author = 'Zhang Lei'
let g:snips_dir='~/.vim/snippets'

" Set location for NetrW bookmarks and history
let g:netrw_home=$HOME

" OCaml stuff
let no_ocaml_comments = 1
set makeprg=ocamlbuild\ ${BUILDFLAGS}\ -use-ocamlfind\ all.otarget

" Syntastic
" let g:syntastic_ocaml_use_ocamlc = 1
let g:syntastic_ocaml_use_ocamlbuild = 1
let g:syntastic_ocaml_checkers = ['merlin']

" Currently disabled
" let g:pathogen_disabled = ['syntastic', 'ocamlmerlin']
set ofu=syntaxcomplete#Complete

" Load matchit
runtime! macros/matchit.vim


if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
