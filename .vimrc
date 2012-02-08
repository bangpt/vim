" Start working on some simplifications
" Adding something to see if the view folder appears"
" Some basic settings
"
     set nocompatible
     runtime! debian.vim

     set nowrap
     
     set number
     set noswapfile
     set go=
     set noerrorbells
	 set notagbsearch
"      set term=builtin_ansi
     " To get rid of charactors when use up, down, right left key
     set novisualbell
     set showmatch
     set nobackup" make saving faster
     set encoding=utf-8
     set cmdheight=2
     set laststatus=2
     set wildchar=<Tab> 
     set wildmenu 
     "set wildmode=list:longest  
     set backspace=indent,eol,start
     set lazyredraw
     set viminfo='20,\"50 " read/write a .viminfo file, don't store more " than 50 lines of registers 
     set history=50 " keep 50 lines of command line history 
     " So that the following type of file will not display on explorer"
     set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif 
     set shortmess+=filmnrxoOtT " abbrev. of messages (avoids 'hit enter')
 " Maximize window size vertically if running on GUI
     if has("gui_running")
 "       set lines=57 columns=100
     endif
 " Support all three CR formats
     set fileformats=unix,dos,mac
 " Use consolse messages instead of GUI dialogs
     set guioptions+=c
 " Map Ctrl-S to save (in insert/normal)
     noremap <C-S> :w<Cr>
     inoremap <C-S> <esc>:w<Cr>
 " Highlight redundant whitespaces and tabs.
     highlight RedundantSpaces ctermbg=red guibg=red
     match RedundantSpaces /\s\+$\| \+\ze\t\|\t/
 " Back to recent buffer    
     nnoremap K :b#<CR>
 "  Close the buffer
     nnoremap <c-down> :bd<cr>
 " Let us move between buffers without writing them.  Don't :q! or :qa! frivolously!
     set hidden

 " Resizing split windows
     nnoremap ,w :call SwapSplitResizeShortcuts()<CR>

 " SwapSplitResizeShortcuts(): Resizing split windows {{{3
     function! SwapSplitResizeShortcuts()
	 if g:resizeshortcuts == 'horizontal'
	     let g:resizeshortcuts = 'vertical'
	     nnoremap _ <C-w><
	     nnoremap + <C-w>>
	     echo "Vertical split-resizing shortcut mode."
	 else
	     let g:resizeshortcuts = 'horizontal'
	     nnoremap _ <C-w>-
	     nnoremap + <C-w>+
	     echo "Horizontal split-resizing shortcut mode."
	 endif
     endfunction
     " }}}3

 " Settings for taglist.vim
     let Tlist_Use_Right_Window=1
     let Tlist_Auto_Open=0
     let Tlist_Enable_Fold_Column=0
     let Tlist_Compact_Format=0
     let Tlist_WinWidth=28
     let Tlist_Exit_OnlyWindow=1
     let Tlist_File_Fold_Auto_Close = 1
     let Tlist_Process_File_Always = 1
     let Tlist_Show_One_File=1
     let Tlist_Sort_Type="order"
"      let Tlist_Display_Prototype=1
     let Tlist_Display_Tag_Scope=1

 " Runtime path: Otherwise installs from AUR don't work
     set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
 " Automatically source vimrc files
 "    autocmd BufWritePost ?vimrc :source %
     runtime macros/matchit.vim

 " Shifting blocks (> and <)
 " Remap the block shifting keys ('>' and '<') to re-visualize the text, so this
 " operation can be repeated multiple times easily.
     vmap    >           >gv
     vmap    <           <gv

 " Don't use Ex mode, use Q for formatting
     nmap Q gq

 " Automatically save before commands like :next and :make
     set autowrite		
 " a: [Enable mouse usage (all modes) in terminals]; v: [visual mode only]
     set mouse=n		

 " Split options
     set splitbelow
     set splitright

     set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
     function! CurDir()
       let curdir = substitute(getcwd(), '/home/bangpt', '~/', 'g')
       return curdir
     endfunction


 " Plugin settings {{{
     let html_use_css=1
     let use_xhtml=1

     let autodate_keyword_pre='Last Modified: '
     let autodate_keyword_post='$'
     let autodate_format='%a %Y-%m-%d %H:%M:%S (%z)'

     let g:EnhCommentifyBindInInsert = 'No'
     let g:EnhCommentifyPretty = 'Yes'
     let g:EnhCommentifyAlignRight = 'Yes'
     let g:EnhCommentifyUserMode = 'Yes'

     let Tlist_GainFocus_On_ToggleOpen = 1
     let Tlist_Exit_OnlyWindow = 1
     let Tlist_File_Fold_Auto_Close = 1
     let Tlist_Enable_Fold_Column = 0
 " }}}

 " Terminal                                                                 "[1]

 " Files, buffers, args, tabs and windows
     " File type detection
     filetype on
     filetype plugin indent on

     " Set directory to current file                                        "[2]
     "autocmd BufEnter * lcd %:p:h
     noremap <silent> ,cd :lcd %:p:h<CR>

     " Quickly scroll through, add and delete buffers
     noremap <C-Left> :bprevious<CR>
     noremap <C-Right> :bnext<CR>
     
     "Moving around windows
     map <c-h> <c-w>h
     map <c-j> <c-w>j
     map <c-k> <c-w>k
     map <c-l> <c-w>l
     map <Tab><Tab> <c-w>w
     nnoremap <c-`> :qa<cr>
 " Moving up & down
     noremap <Space> <PageDown>
     noremap m <PageUp>
     imap <C-W> <C-O><C-W>
 " Use - and + to resize horizontal splits
     map - <C-W>-
     map + <C-W>+

 " Font
     function! MySys()
       if has("win32")
	 return "Windows"
       else
	 return "Ubuntu"
       endif
     endfunction

     if MySys() == "mac"
       set gfn=Bitstream\ Vera\ Sans\ Mono:h14
       set nomacatsui
       set termencoding=macroman
     elseif MySys()=="Ubuntu" 
       set gfn=Consolas\ 9
     elseif MySys()=="Windows"
       set gfn=Consolas:h9
     endif


 "Twitter client
    augroup Twitter
      let twitvim_login = "bangpt:purplesage"
      let twitvim_enable_python = 1
    augroup END
    
"  Moving up/down by function, unfolding current function but folding all else

    noremap [[  [[zMzvz.
    noremap ]]  ]]zMzvz.

" Search
    set ignorecase "Ignore case when searching
    set incsearch
    set magic
    set nohls
    set grepprg=ack
    let Grep_Path = '/usr/bin/ack' 
    nnoremap <F3> "*yw:Ack<space>
    " Allow spaces in filenames
    set isfname+=32
    set showmatch
" Searches the current directory as well as subdirectories with commands like :find, :grep, etc.
    set path=.,**

    function! ToggleHLSearch()
      if &hls
	set nohls
      else
	set hls
      endif
    endfunction
    nmap <silent> <F1> <Esc>:call ToggleHLSearch()<CR>

    function! VisualSearch(direction) range
      let l:saved_reg = @"
      execute "normal! vgvy"
      let l:pattern = escape(@", '\\/.*$^~[]')
      let l:pattern = substitute(l:pattern, "\n$", "", "")
      if a:direction == 'b'
	execute "normal ?" . l:pattern . "^M"
      else
	execute "normal /" . l:pattern . "^M"
      endif
      let @/ = l:pattern
      let @" = l:saved_reg
    endfunction
    "Basically you press * or # to search for the current selection !! Really useful
    vnoremap <silent> * :call VisualSearch('f')<CR>
    vnoremap <silent> # :call VisualSearch('b')<CR>

" Fuzzy search
    let g:fuzzy_ignore = "*.png;*.pyc;*.jpg;*.gif;vendor/**;*.log;coverage/**;tmp/**" 
    let g:fuzzy_matching_limit = 70

    map <leader>f :FuzzyFinderTextMate<CR>
    map <leader>b :FuzzyFinderBuffer<CR>


    function! ToggleScratch()
      if expand('%') == g:ScratchBufferName
	quit
      else
      endif
    endfunction

    map <leader>s :call ToggleScratch()<CR>
" NERD tree
    let NERDTreeIgnore=['.pyc', '.jpg']
    map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" Comments
    noremap <silent> ,c :call EnhancedCommentify('','comment')<CR>
    noremap <silent> ,d :call EnhancedCommentify('','decomment')<CR>
    noremap <silent> ,f :call EnhancedCommentify('','first')<CR>
    noremap <silent> ,g :call EnhancedCommentify('','guess')<CR>
" Quit
    noremap <silent> ,q :q<cr>
" ESC replacement
    imap <m-k> <c-c>
" Command typo
    nmap .; :
" Indent XML readably
    function! DoPrettyXML()
      1,$!xmllint --format --recover -
      endfunction
    command! PrettyXML call DoPrettyXML()

" Programming
"
" Function keys:                                                           "[3]
"   <F4> - save and compile/check for errors, without running
"   <F5> - save, compile and run without parameters
"   <F6> - save, compile and run with parameters
"   <F7> - save, compile and debug without parameters
"   <F8> - save, compile and debug with parameters
"   Memory leaks:
"     <ESC><F5> - save, compile and look for memory leaks without parameters
"     <ESC><F6> - save, compile and look for memory leaks with parameters
" 
" Fixing errors:
"    <ESC>j, <ESC>k, <ESC>h, <ESC>l - :cnext, :cprevious, :colder, :cnewer
"
" There is no binding to run a makefile. I simply open the makefile and use
" either <F5> or <F6>.

""" Sane tabbing — tab vs autocomplete
    function! InsertTabWrapper(direction)
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
	    return "\<tab>"
	elseif a:direction == "back"
	    return "\<c-p>"
	else
	    return "\<c-n>"
	endif
    endfunction
    "TODO: Look at it again, use tab as C-N and C-P is not quit sensible 
    "inoremap <tab> <c-r>=InsertTabWrapper("fwd")<cr>
    "inoremap <s-tab> <c-r>=InsertTabWrapper("back")<cr>


    set suffixesadd+=.py

    "set tags=tags,./tags,../tags,../../tags,../../../tags,../../../../tags,~/tags 
    "set tags+=~/video/trunk/tags " Path to our code 
    "set path+=/home/amit/video/trunk/src,/home/amit/video/trunk/src/runtime 
    "set path+=/usr/local/cuda/include 
    "set tags+=/usr/local/cuda/include/tags 
    "set path+=/home/amit/video/trunk/downloads/src/nvidia_cuda_sdk/common/inc "
"Syntax
    syntax on

" Indentation
    set autoindent
    set smartindent
    set cindent
    set tabstop=4
    set softtabstop=4
    set expandtab
    set shiftwidth=4
    set smarttab
    
    autocmd FileType make set noexpandtab 

" Autocompletion
    autocmd FileType * exe('setlocal dictionary+='.$VIMRUNTIME.'/syntax/'.&filetype.'.vim')

" Map Ctrl-Space to omnicomplete
    inoremap <c-space> <c-x><c-o>
    inoremap <Nul> <C-x><C-o>


" Generic completion of all syntax features
    autocmd FileType * set completefunc=syntaxcomplete#Complete	" automatic based on syntax highlighting
    set completeopt=menu,preview,longest
" Menu for omnifunc/autocomplete, etc
    hi Pmenu cterm=none ctermfg=Green ctermbg=none
    hi PmenuSel cterm=underline ctermfg=White ctermbg=none
    hi PmenuSbar cterm=bold ctermfg=none ctermbg=DarkBlue
    hi PmenuThumb cterm=bold ctermfg=none ctermbg=White

    set complete=.,t
" Auto complete when type .
" Some problem here
    " TODO: To be looked at
    "inoremap <expr> . MayComplete()
    func! MayComplete()
        if ()
            return".\<C-X>\<C-O>"
        endif
        return '.'
    endfunc

" Snippet
    " autocmd FileType * exe('so '.$HOME.'/.vim/after/ftplugin/'.&filetype.'_snippets.vim')

" Folding
    "set foldmethod=manual
    "set foldmethod=marker

    " Folding colors
        " highlight Folded ctermfg=DarkGreen ctermbg=Black

    " Going over errors
    noremap <ESC>j :cnext<CR>
    noremap <ESC>k :cprevious<CR>
    noremap <ESC>h :colder<CR>
    noremap <ESC>l :cnewer<CR>


    " Unmap programming function keys
    augroup unmap_function_keys
        au!
        autocmd BufLeave * silent! unmap <F4>
        autocmd BufLeave * silent! unmap <F5>
        autocmd BufLeave * silent! unmap <F6>
        autocmd BufLeave * silent! unmap <F7>
"         autocmd BufLeave * silent! unmap <F8>
        autocmd BufLeave * silent! unmap <ESC><F5>
        autocmd BufLeave * silent! unmap <ESC><F6>
    augroup END

    " Language-specific
    " -----------------

    " Java
    augroup lang_java
        au!
        let java_highlight_all=1
        let java_highlight_functions="style"
        let java_allow_cpp_keywords=1

        autocmd FileType java map <F4> :w<CR>:!javac %<CR>
        autocmd FileType java map <F5> :w<CR>:!javac % && java %<<CR>
        autocmd FileType java map <F6> :w<CR>:!javac % && java %<<SPACE>
        autocmd FileType java map <F7> :w<CR>:!javac % && jdb %<<CR>
        autocmd FileType java map <F8> :w<CR>:!javac % && jdb %<<SPACE>
    augroup END

    " C
    augroup lang_c
        au!
        " C compile
        autocmd BufEnter *.c map <F4> :w<CR>:!gcc -Wall -g -c % -o %< ; true<CR>
        " C compile and run (w/o, w/ parameters)
        autocmd BufEnter *.c map <F5> :w<CR>:!gcc -Wall -g % -o %< && ./%<<CR>
        autocmd BufEnter *.c map <F6> :w<CR>:!gcc -Wall -g % -o %< && ./%<<SPACE>
        " C debug (w/o, w/ parameters)
        autocmd BufEnter *.c map <F7> :w<CR>:!gcc -Wall -g % -o %< && cgdb %<<CR>
        autocmd BufEnter *.c map <F8> :w<CR>:!gcc -Wall -g % -o %< && cgdb %<<SPACE>
        " Memory leaks (w/o, w/ parameters)
        autocmd BufEnter *.c map <ESC><F5> :w<CR>:!gcc -Wall -g % -o %< && valgrind ./%<<CR>
        autocmd BufEnter *.c map <ESC><F6> :w<CR>:!gcc -Wall -g % -o %< && valgrind ./%<<SPACE>

        " C no spelling
        autocmd BufRead *.c setlocal nospell

        " Automatic ctags
        au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &
    augroup END

    " Perl
    augroup lang_perl
        au!
        autocmd BufEnter *.pl map <F4> :w<CR>:!perl -wc %<CR>
        autocmd BufEnter *.pl map <F5> :w<CR>:!perl %<CR>
        autocmd BufEnter *.pl map <F6> :w<CR>:!perl %<SPACE>
    augroup END

function! PythonSetup()
" Allow gf command to open files in $PYTHONPATH
" au FileType python let &path = &path . "," . substitute($PYTHONPATH, ';', ',', 'g')  
set path=
 
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
 
    try:
        import settings
        from django.core.management import setup_environ
        setup_environ(settings)
        try:
            from django.db.models.loading import get_models
            get_models()
        except: pass
 
        import django
        for mod in ['bin', 'conf', 'contrib', 'core', 'db', 'dispatch', 'forms', \
                    'http', 'middleware', 'shortcuts', 'template', 'templatetags',\
                    'test', 'utils', 'views']:
            try:
                __import__('django.' + mod, globals(), locals(), [], -1)
            except: pass
 
        #class Apps(object):
        # def __init__(self):
        # [setattr(self, name, __import__(name, globals(), locals(), [], -1)) for name in settings.INSTALLED_APPS]
        #setattr(django, 'Apps', Apps())
    except: pass
EOF
set iskeyword=@,48-57,_,192-255
",-,.,@-@ 
set tags+=$HOME/.vim/tags/python.ctags
 
endfunction


    " Python
    augroup lang_python
        au!
        autocmd FileType python map <F4> :w<CR>:!python -c "import py_compile; py_compile.compile('%')"<CR>
        autocmd FileType python map <F5> :w<CR>:!python %<CR>
        autocmd FileType python map <F6> :w<CR>:!python %<SPACE>
        " Django
"         autocmd FileType python so $HOME/.vim/after/ftplugin/django_model_snippets.vim 
"         autocmd FileType python so $HOME/.vim/after/ftplugin/django_template_snippets.vim 
"         autocmd FileType python so $HOME/.vim/after/ftplugin/django_form_snippets.vim 
        autocmd FileType python call PythonSetup()

    augroup END

    " Ruby
    augroup lang_ruby
        au!
        autocmd FileType ruby map <F4> :w<CR>:!ruby -c %<CR>
        autocmd FileType ruby map <F5> :w<CR>:!ruby %<CR>
        autocmd FileType ruby map <F6> :w<CR>:!ruby %<SPACE>
        " Rails
        autocmd FileType ruby,eruby nmap <c-t> /^ *def</c-t>
        autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
        autocmd FileType ruby,eruby so $HOME/.vim/after/ftplugin/rails_snippets.vim
        autocmd FileType eruby so $HOME/.vim/after/ftplugin/xhtml_snippets.vim 
    augroup END

    " Javascript (Rhino)
    augroup lang_javascript
        au!
        autocmd BufEnter *.js map <F5> :w<CR>:!js %<CR>
        autocmd BufEnter *.js map <F6> :w<CR>:!js %<SPACE>
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

    augroup END

    " Bash
    augroup lang_bash
        au!
        autocmd FileType sh map <F4> :w<CR>:!bash -n %<CR>
        autocmd FileType sh map <F5> :w<CR>:!bash %<CR>
        autocmd FileType sh map <F6> :w<CR>:!bash %<SPACE>
    augroup END

    " Vim
    augroup lang_vim
        au!
        autocmd FileType vim map <F5> :w<CR>:source %<CR>:doautoall lang_vim<CR>
    augroup END

    " SQL (PostgreSQL)
    augroup lang_sql
        au!
        let g:sql_type_default = 'pgsql'
        " Requires installation of pgsql.vim in ~/.vim/syntax .
        autocmd FileType sql map <F5> :w<CR>:!psql -f %<CR>
        " This is very unsafe. Remove this unless you're sure you want this.
    augroup END

    " HTML
    augroup lang_html
        au!
        autocmd FileType html map <F6> :w<CR>:silent !firefox %<CR>
        autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"         To tidy up the file
        setlocal makeprg=tidy\ -quiet\ -errors\ %
        setlocal errorformat=line\ %l\ column\ %v\ -\ %m
    augroup END
    
    " CSS
    augroup lang_css
        au!
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    augroup END

    " Make
    augroup lang_make
        au!
        autocmd FileType make map <F5> :w<CR>:!make -f %<CR>
        autocmd FileType make map <F6> :w<CR>:!make -f %<SPACE>
    augroup END

    " Help file
    augroup lang_help
      au FileType help set nonumber      " no line numbers when viewing help
      au FileType help nnoremap <buffer><cr> <c-]>   " Enter selects subject
      au FileType help nnoremap <buffer><bs> <c-T>   " Backspace to go back
    augroup END

" All text
    " Check spelling
    " set spell
    " Wrapping
    set formatoptions=tcqrn
    set textwidth=0 "text insertion max width, 0 means you can type as long as you like I do not know if it is true
    set linebreak "break only at certain characters (see :help breakat) 
    " Dictionary
    "set dictionary=/usr/share/dict/words

" Plain text
    autocmd FileType text setlocal textwidth=0

" Colors
   if has("gui_running")
"           tell the term has 256 colors
       set t_Co=256 
       colorscheme blackboard
       set lines=40
       set columns=115
   else
       let g:CSApprox_loaded = 0
       colorscheme vibrantink 
       colorscheme wombat256 
   endif

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent
" " for HTML, generally format text, but if a long line has been created
" " leave it alone when editing:
autocmd FileType html set formatoptions+=tl
" " for both CSS and HTML, use genuine tab characters for
" " indentation, to make files a few bytes smaller:
autocmd FileType html,css set noexpandtab tabstop=2

" <F1>   <c-x><c-L> completion: whole line
" <F2>   <c-x><c-N> completion: keywords using current file
" <F3>   <c-x><c-K> completion: keywords using dictionary
" <F4>   <c-x><c-T> completion: keywords using thesaurus
" <F5>   <c-x><c-I> completion: keywords in current and included files
" <F6>   <c-x><c-]> completion: tags
" <F7>   <c-x><c-F> completion: file names
" <F8>   <c-x><c-D> completion: definitions or macros
" <F9>   <c-x><c-V> completion: vim command line
" <F10>  <c-x><c-O> completion: omni completion
" ino <silent> <F1>      <c-x><c-L>
" ino <silent> <F2>      <c-x><c-N>
" ino <silent> <F3>      <c-x><c-K>
" ino <silent> <F4>      <c-x><c-T>
" ino <silent> <F5>      <c-x><c-I>
" ino <silent> <F6>      <c-x><c-]>
" ino <silent> <F7>      <c-x><c-F>
" ino <silent> <F8>      <c-x><c-D>
" ino <silent> <F9>      <c-x><c-V>
" ino <silent> <F10>     <c-x><c-O>
" ino <silent> <F11>     <C-O>ma<C-O>yiw<C-O>:ptag <C-R>"<CR><C-O>`a
" ino <silent> <s-left>  <c-x><c-p>
" ino <silent> <s-right> <c-x><c-n>
" ino <silent> <F12>     <c-o>:echo 'completes[ F1:line F2:keywrd F3:dict F4:thes - F5:fromfile F6:tags F7:fname F8:defns - F9:vimcmd F10:omni ] F11:ptag-iw F12:funkey help'<CR>
" "
"

nnoremap <silent> <F2> :TlistToggle<CR>
map <C-V> "+gP
map <S-Insert> "+gP
"cmap <C-V> <C-R>+
"cmap <S-Insert> <C-R>+
 
" Pasting blockwise and linewise selections is not possible in Insert and
" " Visual mode without the +virtualedit feature. They are pasted as if they
" " were characterwise instead.
" " Uses the paste.vim autoload script.
" exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
" exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
"  
"  "imap <S-Insert>    <C-V>
"  "vmap <S-Insert>    <C-V>
"   
"   " Use CTRL-Q to do what CTRL-V used to do

" REFERENCES:
" [1] http://busha.net/archives/38
" [2] http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" [3] http://vim.wikia.com/wiki/Map_function_keys_to_compile_and_run_your_code

