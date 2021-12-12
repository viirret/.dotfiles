"My .vimrc file. This setup is mostly trying to copy the look and feel of VSCode

"not compatible with vi
set nocompatible

"plugins load correcly when this is turned on later
filetype off           

"plugin handle with vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"	Vundle
Plugin 'VundleVim/Vundle.vim'
"https://github.com/VundleVim/Vundle.vim


"	Colorscheme
Plugin 'tomasiser/vim-code-dark'
""https://github.com/tomasiser/vim-code-dark

"	Rainbow brackets
Plugin 'frazrepo/vim-rainbow'
"https://github.com/frazrepo/vim-rainbow


"	Syntax checking
Plugin 'vim-syntastic/syntastic'
"https://github.com/vim-syntastic/syntastic


"	Custom statusline
Plugin 'itchyny/lightline.vim'
"https://github.com/itchyny/lightline.vim


"	YCM autocomplete
Plugin 'ycm-core/YouCompleteMe'
"https://github.com/ycm-core/YouCompleteMe

call vundle#end()
filetype plugin indent on

"	Basic settings
if has ('filetype')
	filetype plugin indent on
endif

if has ('syntax')
	syntax on
endif

set number "display number
"tabs
set tabstop=4
set shiftwidth=4 "
set autoindent
set smartindent
" word VIM will be added to the title
let &titleold="VIM"
set title

set nowrap "no wrapping lines
set hls "highlight search

set wildmenu "better command line completion
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

"""" file syntax highlighting
"autocmd BufNew,BufRead *.asm set ft=nasm


"	Rainbow brackets, default settings except I removed the color red
"	because I find it distracting
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
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'


