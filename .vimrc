call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'


"                               color schemes
Plug 'sonph/onehalf', {'rtp': 'vim/'}
"Plug 'morhetz/gruvbox'


"                               visuality
Plug 'kien/rainbow_parentheses.vim'
"Plug 'yggdroot/indentline'
"
"Plug 'ryanoasis/vim-devicons'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'vwxyutarooo/nerdtree-devicons-syntax'


"                               syntax
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jiangmiao/auto-pairs'
"Plug 'vim-syntastic/syntastic'
"Plug 'tomtom/checksyntax_vim'
"Plug 'dense-analysis/ale'


"                               navigation
"Plug 'tpope/vim-fugitive'
Plug 'dyng/ctrlsf.vim'
"Plug 'kien/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'fcamel/gj'


"                               debugger
Plug 'cpiger/NeoDebug'
Plug 'vim-scripts/valgrind.vim'


"                               cmake
Plug 'vhdirk/vim-cmake'

call plug#end()


"                               general settings
set exrc
set secure
set number
"set paste

" esc in insert mode
inoremap jj <esc>
"make esc do nothing"
inoremap <Esc> <Nop>

let g:mapleader=",,"

set softtabstop=4
set shiftwidth=4
set colorcolumn=140
set expandtab
set tabstop=4
set mouse=a

set nowrap
set ts=4
" Sets automatic tabulation.
set sw=4
syntax on

"set encoding=UTF-8

"search
set incsearch



"                               theme
"colorscheme gruvbox
"set background=dark
set t_Co=256
set cursorline
colorscheme onehalflight
let g:airline_theme='onehalfdark'
let g:airline#extensions#ale#enabled = 1

let s:pink = "CB6F6F"


"                               visual appearance settings
highlight ColorColumn ctermbg=gray

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
"navigate panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"                               settings for syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_loc_list_height=3

hi Directory guifg=#FFFFF0 ctermfg=DarkMagenta


"                               NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeDirArrows = 1
let NERDTreeWinSize=40

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Add bookmarks
let NERDTreeBookmarksFile=expand("~/.vim-NERDTreeBookmarks")
let NERDTreeShowBookmarks=1
let s:Bookmark = {}
let g:NERDTreeBookmark = s:Bookmark


"                               commenting
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("autocmd")
  filetype plugin indent on
endif

command ClearComments 1,$ substitute/\/\/\(.*\)/\/* \1 *\//g
command ClearComPas 1,$ substitute/\/\/\(.*\)/\{ \1 \}/g


vmap cc :norm i//<CR>
vmap uc :norm ^x^x<CR>


" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

"for debugging
"to always do leak checking
let g:valgrind_arguments='--leak-check=yes --num-callers=5000'

"debugging
let output =  system("my_shell_command")
if v:shell_error != 0
    echo output
endif

"easy motion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
