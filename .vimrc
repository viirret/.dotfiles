""My .vimrc file. This setup is mostly trying to copy the look and feel of VSCode


"	Rainbow brackets
"	https://github.com/frazrepo/vim-rainbow
"
"
"	Colorscheme
"	https://github.com/tomasiser/vim-code-dark
"
"
"	Syntax checking
"	https://github.com/vim-syntastic/syntastic
"
"
"	Haskell
"	https://github.com/neovimhaskell/haskell-vim

execute pathogen#infect()

"	load more plugins with Vundle
filetype off           
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"	Vundle
Plugin 'VundleVim/Vundle.vim'
""https://github.com/VundleVim/Vundle.vim

"	Custom statusline
Plugin 'itchyny/lightline.vim'
"https://github.com/itchyny/lightline.vim

"	YCM autocomplete
Plugin 'ycm-core/YouCompleteMe'
"https://github.com/ycm-core/YouCompleteMe

call vundle#end()


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


"	Same configuration in .config/nvim/init.vim, 
"	keeping these just in case  if nvim broky
let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'magenta']


"	default settings for syntax highlighting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"	turn off synctastic for asm
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'passive_filetypes': ['asm'] }

"	custom statusline settings
set laststatus=2
let g:lightline = {
\ 'colorscheme': 'one'	
\ }

" YCM extra settings
let g:ycm_clangd_args=['--header-insertion=never']

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'


"https://github.com/neovimhaskell/haskell-vim"
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords


