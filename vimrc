source ~/.dotfiles/vimrc.bundles

set history=5000

let mapleader = ","
syntax on
set number

" Mappings {{{
if exists('*togglebg#map')
    call togglebg#map("<F5>")
endif

" Insert mode mappings {{{
inoremap <C-s> <Esc>:w<CR>a

map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste!<CR>
set pastetoggle=<F11>

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>
" }}}

" Normal mode mappings {{{
nnoremap <C-s> :w<CR>
nnoremap <leader>ev :vs $MYVIMRC<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>m :NERDTreeToggle<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>l :ls<CR>:b
" }}}

command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

" Visual mode mappings {{{
vnoremap < <gv
vnoremap > >gv
xnoremap . :normal .<CR>
" }}}

setlocal smartindent
setlocal autoindent
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set fileencoding=utf-8
set hlsearch
set ignorecase
set incsearch
set smartcase
set noswapfile
set splitright
set hidden
set ts=4 sts=4 sw=4 expandtab
"set term=screen-256color

"let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Statusline {{{
hi User1 ctermbg=white    ctermfg=black   guibg=#89A1A1 guifg=#002B36
hi User2 ctermbg=red      ctermfg=white   guibg=#aa0000 guifg=#89a1a1

function! GetCWD()
    return expand(":pwd")
endfunction

function! IsHelp()
    return &buftype=='help'?' (help) ':''
endfunction

function! GetName()
    return expand("%:t")==''?'<none>':expand("%:t")
endfunction

set statusline=%1*[%{GetName()}]\
set statusline+=%<pwd:%{getcwd()}\
set statusline+=%2*%{&modified?'\[+]':''}%*
set statusline+=%{IsHelp()}
set statusline+=%{&readonly?'\ (ro)\ ':''}
set statusline+=[
set statusline+=%{strlen(&fenc)?&fenc:'none'}\|
set statusline+=%{&ff}\|
set statusline+=%{strlen(&ft)?&ft:'<none>'}
set statusline+=]\
set statusline+=%{fugitive#statusline()}
set statusline+=%=
set statusline+=C%c
set statusline+=,L%l
set statusline+=/%L\

set laststatus=2

" }}}

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
