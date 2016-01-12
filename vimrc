" Install :
" git clone https://github.com/MarcWeber/vim-addon-manager ~/.vim/vad

" {{{ Vim options

" Disable vi compatibility
set nocompatible

" Use utf-8
set encoding=utf-8

" Smoothness
set ttyfast
set lazyredraw

" Save when doing some commands
set autowrite

" no swp/~
set nobackup
set noswapfile

" Keep undo history after closing vim/buffer
" try
"   set undofile
"   set undodir=$HOME/.vim/tmp/undo
"   if windows
"     set undodir=$HOME/_vim/tmp/undo
"   else
"     set undodir=$HOME/.vim/tmp/undo
"   endif
" catch
" endtry
set undodir=~/.vim/undo
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload


" Remember info about open buffers on close
set viminfo^=%

" Keep unsaved buffers
set hidden

" Disable beep
set visualbell
set t_vb=

let g:is_posix = 1

" leader on space
let mapleader = "\<Space>"

" }}}
"{{{ Windows

let windows = has("win32") || has("win64")

if has("gui")
    " GUI font
    set guifont=Ubuntu_Mono:h14

    "remove menu bar
    set guioptions-=m

    "remove toolbar
    set guioptions-=T

    "remove right-hand scroll bar
    set guioptions-=r

    " Allways have block cursor
    set guicursor=n-c-v-i:block
endif

""}}}
" Plugins {{{

set nocompatible | filetype indent plugin on | syn on

if windows
  set rtp+=~/_vim/vad
else
  set rtp+=~/.vim/vad
endif

let addons = []

" File finder
let addons += ['github:kien/ctrlp.vim']

" Easy commenting
let addons += ['github:scrooloose/nerdcommenter']
let addons += ['github:tpope/vim-commentary']
" let addons += ['github:vim-scripts/tComment']

" Syntax check on save
" let addons += ['github:scrooloose/syntastic']
" let addons += ['github:walm/jshint.vim']

" Autocompletion
let addons += ['github:vim-scripts/OmniCppComplete']
" let addons += ['github:vim-scripts/ActionScript-3-Omnicomplete']

" let addons += ['github:vim-scripts/myhere/vim-nodejs-complete']
" let addons += ['github:vim-scripts/ahayman/vim-nodejs-complete']

" let addons += ['github:vim-scripts/AutoComplPop']
" let addons += ['github:Shougo/neocomplete.vim']

let addons += ['github:Valloric/YouCompleteMe']


" Search
let addons += ['github:mileszs/ack.vim']

" tagbar
let addons += ['github:majutsushi/tagbar']

" Navigate between files
let addons += ['github:scrooloose/nerdtree']

" Choose windows
let addons += ['github:t9md/vim-choosewin']

" Surround
let addons += ['github:tpope/vim-surround']

" Press +/- to shrink/expand visual selection
" let addons += ['github:terryma/vim-expand-region']

" Yank history
let addons += ['github:vim-scripts/YankRing.vim']

" End certain sutructures automatically or autocomplete
" let addons += ['github:tpope/vim-endwise']
" let addons += ['github:Townk/vim-autoclose']
" let addons += ['github:kana/vim-smartinput']

" Some plugins needs that
let addons += ['github:mattn/webapi-vim']

" Allign stuff
let addons += ['github:godlygeek/tabular']

" Make . work for plugin things
let addons += ['github:tpope/vim-repeat']

" Debug
" let addons += ['github:sidorares/node-vim-debugger']

" Node tools
let addons += ['github:moll/vim-node']

" Html thingie
let addons += ["github:mattn/emmet-vim"]

" Colorschemes
let addons += ['github:nanotech/jellybeans.vim']
let addons += ['github:altercation/vim-colors-solarized']
let addons += ['github:sjl/badwolf']
let addons += ['github:marcus/vim-mustang']
let addons += ['github:goatslacker/mango.vim']
let addons += ['github:morhetz/gruvbox']


" Added, modified and removed lines
let addons += ['github:mhinz/vim-signify']
" let addons += ['github:airblade/vim-gitgutter']

" Status bar
let addons += ['github:bling/vim-airline']
" let addons += ['github:Lokaltog/vim-powerline']

" Git vrapper
let addons += ['github:tpope/vim-fugitive']

" Gist
let addons += ['github:mattn/gist-vim']

" Vimdiff on directories
let addons += ['github:vim-scripts/DirDiff.vim']

" Syntax/indent/dict/ctag
" let addons += ['github:marijnh/tern_for_vim']
" let addons += ['github:kchmck/vim-coffee-script']
" let addons += ['github:slim-template/vim-slim']
let addons += ['github:hynek/vim-python-pep8-indent']
let addons += ['github:hdima/python-syntax']
let addons += ['github:vim-scripts/armasm']
let addons += ['github:wting/rust.vim']
let addons += ['github:elzr/vim-json']
let addons += ['github:tpope/vim-markdown']
let addons += ['github:pangloss/vim-javascript']
" let addons += ['github:jelera/vim-javascript-syntax']
" let addons += ['github:vim-scripts/JavaScript-Indent']
let addons += ['github:guileen/vim-node-dict']
" let addons += ['github:othree/html5.vim']
" let addons += ['github:mklabs/vim-backbone']
let addons += ['github:mxw/vim-jsx']

" Silly
let addons += ['github:jbgutierrez/vim-babel']

call vam#ActivateAddons(addons, {'auto_install' : 1})

VAMActivate tlib matchit.zip

" }}}
" {{{ Plugin options/mappings

if windows
    let g:yankring_history_dir = '$HOME/vimfiles/tmp'
else
    let g:yankring_history_dir = '~/.vim/tmp'
endif

" let g:jellybeans_background_color_256='256'

let g:syntastic_cpp_compiler_options = ' -std=c++0x'
let g:syntastic_python_python_exe = 'python3'
let g:syntastic_python_checkers = []
let g:syntastic_c_include_dirs = ['/home/yaon/k/kaneton/include']
let g:syntastic_c_check_header = 1
let g:syntastic_c_no_default_include_dirs = 1
" let g:syntastic_warning_symbol -= '-Wint-to-pointer-cast'
let g:syntastic_javascript_checkers = ['jshint']

let python_highlight_all = 1

let NERDTreeQuitOnOpen  = 0   " don't collapse NERDTree when a file is opened
let NERDTreeMinimalUI   = 0
let NERDTreeDirArrows   = 0
let NERDTreeChDirMode   = 0
let NERDTreeIgnore      = ['\.pyc$', '\.rbc$', '\~$']
let NERDTreeHijackNetrw = 0
let g:nerdtree_tabs_startup_cd = 0

" Nerdtree
map <leader>nt :NERDTreeToggle<cr>

" Tabular
map <leader>tb :Tabularize /

" CtrlP
let g:ctrlp_map = '<c-e>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|bower_components)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Synstastic errors
map <leader>ee :Errors<cr>

" Show yanks
map <leader>ys :YRShow<cr>

" Git diff
map <leader>gd :Gdiff<cr>

" Choosewin
map <leader>ch :ChooseWin<CR>

" Colorscheme
" set t_Co=256
" syntax enable
set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized
" colorscheme jellybeans
colorscheme gruvbox

" Where the tags files are present
" set tags+=~/k/tags, fuck this

" Tagbar
map <leader>ta :TagbarToggle<CR>

" " OmniCppComplete
let OmniCpp_NamespaceSearch     = 1
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_ShowAccess          = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot      = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow    = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope    = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces   = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

 " Airline
let g:airline#extensions#whitespace#checks = []
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='tomorrow'
" let g:airline_theme='wombat'

" if you want to use overlay feature
let g:choosewin_overlay_enable          = 1

" overlay font broke on mutibyte buffer?
let g:choosewin_overlay_clear_multibyte = 1

" Use # insted of /**/ for asm commenting
au Filetype asm set commentstring=#\ %s
" }}}
" {{{ Bottom things

" Show line/column size of visuals
set showcmd

" History size for commands
set history=1000

" Show number of lines changed
set report=0

" Show status bar
set laststatus=2

" Enable ruler
set ruler

" Enable /g by default for substitution
set gdefault

" Completion for commands
set wildmenu
set wildmode=list,full
set wildignore=*.o,*~,*.pyc
set wildignorecase

" Leaving insert mode instantly
set ttimeout
set ttimeoutlen=1
"
" Amazing '/'
set hlsearch
set smartcase
set incsearch
set ignorecase

" }}}
" {{{ Edit, motion, indent...

" Indent spaces
set shiftwidth=4

" Number of spaces in a tab
set tabstop=8

" Number of spaces inserted when pressing <TAB>
set softtabstop=8

" <TAB> goes to indent level
set smarttab

" Automatic indentation
set autoindent
set smartindent

" Break lines before 120th column
set textwidth=119
set wrapmargin=100

" Insert spaces insted of tabs
set expandtab

" Indent options
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,ps,t0,(0,u0,)20,*80,g0

" Do not insert comment automatically
autocmd FileType * setlocal fo-=c fo-=r fo-=o

" Completion options
set complete=.,w,b,u,U,k,kspell,i,t

" Working backspace
set backspace=indent,eol,start

" Number of lines between cursor and edge
set scrolloff=5

" Motion stuff
set whichwrap=b,s,l,h,<,>,[,]

" Delte trailing whitespaces on save
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
au BufWrite *.py :call DeleteTrailingWS()

" You didn't see that
set mouse=ar
set mousemodel=extend
set mousefocus
set mousehide

" Move and split
set splitright
set splitbelow

" }}}
" {{{ Prettify

" No wrapped lines ?
set nowrap

" For wrapped lines
set showbreak=\

" Spellcheking
" highlight SpellBad term=underline gui=undercurl

" 7.4 Relative line numbers
set relativenumber
set number
" Line numbers in insert mode and relative in command mode
" autocmd InsertEnter * :set number
" autocmd InsertLeave * :set relativenumber

" Cool looking vertical splits
set fillchars=vert:│

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Show trailing whitespaces and tabs
set list
set listchars=tab:▸\ ,

" Vertical line at textwidth
set colorcolumn=+1

" Highlight cursor line
set cursorline
"
" Enable 256 color terminal
set t_Co=256

" Show matching brackets when text indicator is over them
set showmatch

" Magnificient folds
set foldenable
set foldlevel=99
set foldlevelstart=0
set foldmethod=marker

" }}}
" {{{ Functions / whitchcraft

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" include colon in filenames (for gf)
set isfname+=:

" " ----- Emulate 'gf' but recognize :line format -----
" function! GotoFile(w)
"     let curword = expand("<cfile>")
"     if (strlen(curword) == 0)
"         return
"     endif
"     let matchstart = match(curword, ':\d\+$')
"     if matchstart > 0
"         let pos = '+' . strpart(curword, matchstart+1)
"         let fname = strpart(curword, 0, matchstart)
"     elseif
"         let pos = ""
"         let fname = curword
"     endif
"     " Open new window if requested
"     if a:w == "new"
"         new
"     endif
"     " Use 'find' so path is searched like 'gf' would
"     execute 'find ' . pos . ' ' . fname
" endfunction

"Source .vimrc on close, kills my term...
"autocmd bufwritepost .vimrc source $MYVIMRC


" }}}
"{{{ Colors

" Magnificent search colors, here because reasons
hi Search ctermfg=214 ctermbg=236 cterm=bold

" use an orange cursor in insert mode
let &t_SI = "\<Esc>]12;white\x7"
" use a red cursor otherwise
let &t_EI = "\<Esc>]12;green\x7"
silent !echo -ne "\033]12;white\007"
" reset cursor when vim exits
autocmd VimLeave * silent !echo -ne "\003]12;white\007"
" use \003]12;gray\007 for gnome-terminal

match PmenuSbar '\s\+$'
hi cFormat ctermbg=240

"}}}
"{{{ Map

" Gold
map ; :

" I use capslock too sir
imap jk <esc>

" Visual studio mode with vsvim
"behave mswin

" Backspace to delete visual selection
vmap <BS> d

" Getting rid of control commands (not really using UHL anyways)
nmap vv <C-V>
noremap U <C-R>
nmap H <C-D>
nmap L <C-U>

" Basic stuff
map <leader>w :w<cr>
map <leader>q :q<cr>
map <leader>x :x<cr>
map <leader>W :w!<cr>
map <leader>Q :q!<cr>
map <leader>X :x!<cr>

" Move up/down correctly in wrapped lines
map j gj
map k gk

" Paste !
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Keep visual mode during indenting
vmap > >gv
vmap < <gv

" Stop highlighting search
map <leader>nh :nohlsearch<cr>

" Dompter le tigre
map <leader>ms :silent! :make -j4 \| :redraw! \| :botright :cw<cr>
map <leader>mk :!clear && make<cr>
map <leader>me :!clear && make exe<cr>
map <leader>mt :!clear && make test<cr>
map <leader>mb :!clear && make debug<cr>
map <leader>md :!clear && make deploy<cr>
map <leader>mr :!clear && make run<cr>
map <leader>mw :!clear && make run_wifi<cr>

" Execute current file
map <leader>mf :!clear<cr>:!%:p<cr>

" Node current file
map <leader>mf :!clear<cr>:!node %:p<cr>

" Node current file
map <leader>mn :!clear<cr>:!node %:p<cr>

map <leader>ma :!clear<cr>:!gnatmake %:p && ./main<cr>

" Clean dirty disgusting pig stuff
map <leader>ric :retab<cr>gg=G<cr>:%s/[\r \t]\+$//<cr>

" Split resize
map <C-up> :resize +2<cr>
map <C-down> :resize -2<cr>
map <C-left> :vertical resize +2<cr>
map <C-right> :vertical resize -2<cr>

map <leader>jj <c-w>w:vertical resize +41<CR>

" Faster way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Execute current file | less
" map <leader>el :!clear<cr>:!%p<cr>

" Rename current file
map <Leader>mv :call RenameFile()<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Visual mode pressing * or # searches for the current selection
vmap <silent> * :call VisualSelection('f')<cr>
vmap <silent> # :call VisualSelection('b')<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Toggle wrap line mode on and off
map <leader>pw :set wrap!<cr>

" Override vim commands 'gf', '^Wf', '^W^F'
" nmap gf :call GotoFile("")<cr>
" nmap <C-W>f :call GotoFile("new")<cr>
" nmap <C-W><C-F> :call GotoFile("new")<cr>

" Arduino
map <leader>mia :!sudo ino build && sudo ino upload && sudo ino serial<cr>
map <leader>miu :!sudo ino build && sudo ino upload<cr>
map <leader>mis :!sudo ino serial<cr>
map <leader>mib :!sudo ino build<cr>

" Use :W! to write to a file using sudo if you forgot to 'sudo vim file'
cmap W! %!sudo tee > /dev/null %

" Source vimrc
map <leader>so :source $MYVIMRC<cr>

" Select (charwise) the contents of the current line, excluding indentation.
map <leader>v ^vg_"

" Open .vimrc
map <leader>ev <C-w><C-v><C-l>:e ~/tools/vimrc<cr>
map <leader>tv :tabnew ~/tools/vimrc<cr>

" Select (linewise) the text you just pasted (handy for modifying indentation)
map <leader>V v`]

" Reload file
map <leader>lf :edit!<cr>

" don't
" map <up>    <nop>
" map <down>  <nop>
" map <right> <nop>
" map <left>  <nop>
" map <tab>   <nop>

" Erase and paste in visual mode
vmap p "_dP
" vmap p <esc>:let @z=@0<CR>gvd"zP

" Open CrtlP in new vsplit
map <leader>sp :vs<CR>:CtrlP<CR>
map <leader>tp :tabnew<CR>:CtrlP<CR>

" Idea !
map <CR> <C-d>
map <BS> <C-u>

" fold indent mode
map <leader>fi :se foldmethod=indent<CR>
map <leader>fm :se foldmethod=marker<CR>


" grep
map <leader>gr :!grep --color=auto -rnI '' .<left><left><left>
map <leader>ag :!ag '' .<left><left><left>

" indent
map <leader>= mj=i{`j

" Syntax swap for jsx, gotta figure out a better way
map <leader>sh :se filetype=html<CR>
map <leader>sj :se filetype=javascript<CR>

" }}}
" {{{ File types
" Python colon
" au Filetype javascript se sw=4
" au Filetype html se sw=4
au Filetype *.gradle se ft=java
au Filetype *.ejs se ft=html
au Filetype *.json se sw=2
au Filetype python se sw=4
au Filetype python iabbr def def:<left>
au Filetype python iabbr if if:<left>
au Filetype python iabbr while while:<left>
au Filetype python iabbr for for:<left>
au Filetype python iabbr with with:<left>
au BufRead,BufNewFile *.ejs set filetype=html
" }}}

vmap <leader>ll diconsole.log("<esc>pA", <esc>pA);

map <leader>jmv :JavaRename 
map <leader>jgs :JavaGetSet<cr>
map <leader>jg :JavaGet<cr>
map <leader>js :JavaSet<cr>
map <leader>jch :JavaCallHierarchy <cr>
map <leader>jim :JavaImpl<cr>
map <leader>jin :JavaImport<cr>
map <leader>js :JavaSearchContext<cr>
map <leader>je :JavaSearch 
let g:jsx_ext_required = 0
let g:EclimCompletionMethod = 'omnifunc'
