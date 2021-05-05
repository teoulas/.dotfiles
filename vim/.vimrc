call plug#begin('~/.vim/plugged')

" vim-plug packages
Plug 'mileszs/ack.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/endwise.vim'
Plug 'vim-scripts/fugitive.vim'
Plug 'tpope/vim-haml'
Plug 'othree/html5.vim'
Plug 'vim-scripts/The-NERD-tree'
Plug 'tpope/vim-rails'
Plug 'vim-scripts/surround.vim'
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
" alternatively: peitalin/vim-jsx-typescript
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-ruby/vim-ruby'
Plug 'jpo/vim-railscasts-theme'
Plug 'ap/vim-css-color'
Plug 'ruanyl/vim-gh-line'
Plug 'pechorin/any-jump.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-sleuth'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'yssl/QFEnter'

call plug#end()

" Autoinstall plugins on first run
if !isdirectory($HOME . '/.vim/plugged')
  PlugInstall
endif

filetype plugin indent on

" Custom config
set history=1000      " longer history
set showcmd           " show incomplete cmds down the bottom
set showmode          " show current mode down the bottom

set incsearch         " find the next match as we type the search
set hlsearch          " highlight searches

set relativenumber    " add relative line numbers - SLOW
set cursorline        " underline current (cursor) line - SLOW
set ruler             " show row/col at the bottom right
set signcolumn=number

set nowrap            " no wrapping
set colorcolumn=80    " but show a line at 80 chars

" optimization settings to alleviate sluginess
"set re=1              " older regex engine is faster for Ruby regexes
set re=0              " or TypeScript highlighting takes forever
set lazyredraw

" whitespace characters
set list
set listchars=tab:⇥\ ·,nbsp:␣,eol:↲,trail:␠

"indent settings
set tabstop=4
set shiftwidth=4
"set softtabstop=2
"set expandtab
set autoindent

"status line
set statusline=%f
set statusline+=%{fugitive#statusline()}
set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}
set statusline+=%=        "left/right separator
set statusline+=%c,
set statusline+=%l/%L
set statusline+=\ %P

"remove GUI toolbar
set guioptions-=T

syntax on

let NERDTreeMinimalUI=1

colorscheme railscasts
set mouse=a

"keyboard
let mapleader = ","

nnoremap <leader>b :BufExplorer<cr>
nnoremap <leader>p :CtrlPMixed<cr>
nnoremap <leader>a :Ack! --word-regexp <cword><cr>
silent! nmap <silent> <leader>t :NERDTreeToggle<cr>

"command aliases for when I keep shift down a bit too long after the colon
command W w
command Q q

"replace ack with ag
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

"fixes background color erase issue: https://sw.kovidgoyal.net/kitty/faq.html#id3
if $TERM == 'xterm-kitty'
  let &t_ut=''
endif

"greek keymap, CTRL+6 to switch
set keymap=greek_utf-8
set iminsert=0
set imsearch=-1

" Current filename in title
set title

" ctrlP plugin config
let g:ctrlp_root_markers = ['Gemfile', '.gitignore', 'go.mod', 'yarn.lock']
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" vim-gh-line config
let g:gh_use_canonical = 1
let g:gh_open_command = 'xdg-open '

" coc language servers
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-json', 'coc-css', 'coc-html', 'coc-go']
set updatetime=1000

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Svelte as html
au! BufNewFile,BufRead *.svelte set ft=html

" QFEnter keymap similar to ctrlP
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" Resize splits on window resize
autocmd VimResized * wincmd =

" navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

