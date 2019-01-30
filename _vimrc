filetype off

fun! MySys()
    return "windows"
endfun

set nocompatible
let vundleAlreadyExists=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    if isdirectory(expand('~/.vim/bundle')) == 0
        call mkdir(expand('~/.vim/bundle'), 'p')
    endif
    execute 'silent !git clone https://github.com/gmarik/vundle "' . expand('~/.vim/bundle/Vundle.vim') . '"'
    let vundleAlreadyExists=0
endif

" Vundle support
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
"General section
Plugin 'Lokaltog/vim-easymotion'
"" This plugin is for searching
"" 1. Jump to a begining of a word <leader><leader>w: activate the word jumping mode
"" 2. Jump to a letter: <leader><leader>fo: find and highlight the letter o to jump to
"" 3. 2 letter search
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

" This is to rearrange the text by left, center, or right aligh
Plugin 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"https://github.com/junegunn/vim-easy-align
" We use ga to act on an text object at anymode
Plugin 'tpope/vim-repeat'
" It is used with other plug in
Plugin 'tpope/vim-surround'
" Very useful for html editing
" Here is an example. We have 'Hello World' we can use cs'" inside the hello,to change surround ' to ".
" We can change to a tag cs'<q>, change tag to \": cst", delete the delimiters: ds"
Plugin 'SirVer/ultisnips'

let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsListSnippets="<c-s-tab>"

let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

inoremap <c-x><c-k> <c-x><c-k>

Plugin 'scrooloose/nerdtree'
" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <C-n> :NERDTreeToggle<CR>
" Keep NERDTrece window fixed between multiple toggles
set winfixwidth

Plugin 'kana/vim-textobj-user'
" This is an extend of vim-text-user object
" additionaly here https://github.com/kana/vim-textobj-user/wiki

Plugin 'Spaceghost/vim-matchit'

Plugin 'vim-scripts/scratch.vim'

" Fancy
Plugin 'bling/vim-airline'
" Indent
Plugin 'Yggdroot/indentLine'
" Very good plugin, now I can get rid of indenting using tabs with all its limitation
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#DADADA'
let g:indentLine_char = '¦'

Plugin 'majutsushi/tagbar'
" Should have ctags installed, the shortcut key is duplicated with easymotion
nmap <F8> :TagbarToggle<CR>

Plugin 'scrooloose/nerdcommenter'
"<leader>c<space> is enough

"Plugin 'OmniSharp/omnisharp-vim'
Plugin 'OrangeT/vim-csharp'

Plugin 'tpope/vim-fugitive'
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit -v<CR>
nmap <leader>gac :Gcommit --amen -v<CR>
nmap <leader>g :Ggrep
" ,f for global git search for word under the cursor (with highlight)
nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent vimgrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
" same in visual mode
vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>


"autocmd FileType gitcommit set tw=68 spell
autocmd FileType gitcommit setlocal foldmethod=manual


Plugin 'Shougo/neocomplete'
let g:neocomplete#enable_at_startup = 1

Plugin 'flazz/vim-colorschemes'
Plugin 'yuttie/comfortable-motion.vim'

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/goyo.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-scripts/CmdlineComplete'


function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

call vundle#end()
" Installing plugins the first time
if vundleAlreadyExists == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    " Executing below line Causes Vim to crash.
    " The bug has been reported @ https://github.com/gmarik/vundle/issues/275
    execute 'PluginInstall'
endif

" OmniSharp won't work without this setting
filetype plugin on

" Set the type lookup function to use the preview window instead of echoing it
"let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview

" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono).
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
    autocmd!

    " When Syntastic is available but not ALE, automatic syntax check on events
    " (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>


    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Add syntax highlighting for types and interfaces
nnoremap <Leader>th :OmniSharpHighlightTypes<CR>

" Enable snippet completion
let g:OmniSharp_want_snippet=1
"
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType cs setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" Color
" ================================
syntax enable
filetype indent on

"" Spaces and tabs
"" ================================
set tabstop=4		" The width of a TAB is set to 4.
"" Still it is a \t. It is just that
"" Vim will interpret it to be having
"" a width of 4.

set shiftwidth=4	" Indents will have a width of 4
set softtabstop=4	" Sets the number of columns for a TAB
set expandtab		" Expand TABs to spaces

"" UI
"" ================================
set number "Show the line number
set showcmd "show the command bar at the bottom
"" Cursorline {{{
"" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:␣
    au InsertLeave * :set listchars+=trail:␣
augroup END

"set wildmenu "Turn on wildmenu autocomplete menu in command bar or other
function! ReplaceCurrentWord()
    let search = substitute(escape(expand('<cword>'), '\'), '\n', '\\n', 'g')
    execute 'noautocmd vimgrep /'.search.'/ **'
    copen
endfunction

set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,*.swp,*.jpg,*.png,*.gif,*.pdf,*.bak,.svn,.hg,.bzr,.git,
set cmdheight=1 "The commandbar height
set shortmess=atI " Shortens messages in status line, truncates long messages, no intro (Uganda) message.
set laststatus=2 " Always show status line.

"filetype indent on "Set indent specific by file type

set lazyredraw "Redraw
set showmatch "Show matching bracets when text indicator is over them
set nolist "Show no special characters

" Instantly leave insert mode when pressing <Esc> {{{
" This works by disabling the mapping timeout completely in normal mode,
" and enabling it in insert mode with a very low timeout length.
augroup fastescape
    autocmd!

    set notimeout
    set ttimeout
    set timeoutlen=10

    au InsertEnter * set timeout
    au InsertLeave * set notimeout
augroup END

"" Set 7 lines to the curors - when moving vertical..
set so=7

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


set noshellslash

" Searching
" ================================
set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers, search as character entered
set ignorecase "Ignore case when searching
set smartcase "If /The then it will find The only, /the will find both The and the

:highlight Search ctermbg=yellow ctermfg=black
" Do the same for gvim
:highlight Search guibg=yellow guifg=black

"Turn off search highline
nnoremap <CR> :nohlsearch<CR>

set nolazyredraw "Don't redraw while executing macros
set gdefault "So do do not have to type /g when replace or search
set magic "Set magic on, for regular expressions

set mat=10 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set tm=500

" Split options
set splitbelow
set splitright

" Movement
" ================================
" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>


" You want to be part of the gurus? Time to get in serious stuff and stop using
" arrow keys.
noremap <left> <nop>
noremap <up> <nop>
noremap <down> <nop>
noremap <right> <nop>

" Smart way to move btw. windows
map <c-j> <C-W>j
map <c-k> <C-W>k
map <c-h> <C-W>h
map <c-l> <C-W>l
" Move up and down page long
map <space> <c-d>
map m <c-u>
" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Enable filetype plugin
filetype plugin on
"set nofoldenable

set history=700


" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Saving
" ====================================
" Fast saving
nmap <leader>w :w!<cr>
" save session
nnoremap <leader>s :mksession<CR>

" Save when losing focus
au FocusLost	* :silent! wall
"

autocmd BufWritePre * :%s/\s\+$//e
map <F7> mzgg=G`z

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
if MySys() == "mac"
    set gfn=Menlo:h12
    set shell=/bin/bash
elseif MySys() == "windows"
    set gfn=Consolas:h10
elseif MySys() == "linux"
    set gfn=Droid\ Sans\ Mono\ 9
    set shell=/bin/bash
endif

set guioptions=
set guioptions+=c "Asking using message in commanline area not as dialog
set t_Co=256
set background=dark
colorscheme badwolf

set encoding=utf8

set ffs=dos,unix,mac "Default file types

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowritebackup
set nowb
set nomodeline
set noswapfile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smarttab

set lbr
set tw=500

set ai "Auto indent
set nowrap

"""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""
"" NOTICE: Really useful!

""  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>
"Ack 'Ack' after the selected text
vnoremap <silent> av :call VisualSelection('av')<CR>


"
" From an idea by Michael Naumann
"
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
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
    elseif a:direction == 'av'
        call CmdLine("Ack " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! Refactor()
    call inputsave()
    let @z=input("What do you want to rename '" . @z . "' to? ")
    call inputrestore()
endfunction

" Locally (local to block) rename a variable
nmap <Leader>rf "zyiw:call Refactor()<cr>mx:silent! norm gd<cr>[{V%:s/<C-R>//<c-r>z/g<cr>`x

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $j e ./


func! Cwd()
    let cwd = getcwd()
    return "e " . cwd
endfunc

"let g:snips_trigger_key='<c-space>'
set clipboard=unnamed "unnamedplus,autoselect
" Close the current buffer
map <leader>bd :Bclose<cr>


" Tab configuration
map <leader>t :tabnew<cr>
map <leader>tc :tabclose<cr>
" gt: Next tab, gT: Previous tab, tabfir: first tab, tabl: last tab

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\						 " buffer number
set statusline+=%f\							 " file name
set statusline+=%h%m%r%w					 " flags
set statusline+=[%{strlen(&ft)?&ft:'none'}]  " filetype
set statusline+=%=							 " right align
set statusline+=%{strftime(\"%a\ %d-%b-%Y\ %I:%M\ %p\")}\ \  " space," need escaping

" Mouse {{{
"Set mouse behaviour to be like the OS's.
if has ("win32") | behave mswin | else | behave xterm | endif
"set mouse-=a " Disable mouse.
set mouse=a " Enable mouse.
set mousehide " Hide mouse when typing
behave xterm " Make mouse behave like in xterm (instead of, e.g. Windows' command-prompt mouse).
set selectmode=mouse " Enable visule selection with mouse.
"}}}
"Remeber open buffers on close
set viminfo^=%
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
