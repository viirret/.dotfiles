""My .vimrc file. This setup is mostly trying to copy the look and feel of VSCode

execute pathogen#infect()

"	Basic settings

"	not compatible with vi
set nocompatible

if has ('filetype')
	filetype plugin indent on
endif

if has ('syntax')
	syntax on
endif

set number
set relativenumber

"	tabs
set tabstop=4
set shiftwidth=4 "
set autoindent
set smartindent

"	title
set titleold="VIM"
set title

set shell=/bin/bash

set nowrap 		"no wrapping lines
set hls 		"highlight search
set wildmenu 	"better command line completion
set clipboard=unnamed

" 	Bracket handling, VSCode style
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap (  ()<ESC>hli
inoremap [	[]<ESC>hli
inoremap "	""<ESC>hli
inoremap '	''<ESC>hli

"	Easy switching between tabs
nnoremap <C-Left> :tabprevious<CR>                                                                            
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>                                                                            
nnoremap <C-k> :tabnext<CR>

"	Colorscheme settings, VSCode colors
colorscheme codedark
set t_Co=256


"	rainbow colors
let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'magenta']


"	custom statusline settings
set laststatus=2
let g:lightline = {
\ 'colorscheme': 'one'	
\ }

" YCM extra settings
let g:ycm_clangd_args=['--header-insertion=never']

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

