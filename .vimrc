" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch        " highlight searched text
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set mouse=v

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" ****************************Edited by Kavon Ma*****************************
set tabstop=4			"set tab length 4
set shiftwidth=4
set expandtab     "expand TAB to spaces
set nu					"set line number
set nobackup
set clipboard+=unnamed  " share clip board

"字体
""if (has("gui_running"))
" set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
" "endif
"
" set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
" set termencoding=utf-8
" set encoding=utf-8
" set fileencodings=ucs-bom,utf-8,cp936
" set fileencoding=utf-8

" mapping set
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap empty :g/^\s*$/d<CR>
" map <F7> GoDate: <Esc>:read !date<CR>kJ
" omap <F7> a{

" user-defined commands
command Yes :!source ~/.bashrc
command -nargs=+ Say :echo "<args>"
command Annotation :!cvs ann % > %:r.ann;vi %:r.ann;rm %:r.ann
command Log :!cvs log % > %:r.log;vi %:r.log;rm %:r.log
command Diff :!cvs diff -uN -U 30 % > %:r.diff;vi %:r.diff;rm %:r.diff

set cursorline			"highlight the corrent line
" set background=dark
set autoindent
set smartindent			"set auto alighment
set smarttab            "smart tab
set ruler				"status display 
" colorscheme delek
" colorscheme slate
  colorscheme desert

"pathogen
call pathogen#infect()
call pathogen#helptags()
syntax enable
syntax on
filetype plugin indent on

filetype off 

set history=1000
set nocompatible

let mapleader=","
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>wq :wq<CR>
"Cscope Setting
if has("cscope")

	""""""""""""" Standard cscope/vim boilerplate

	" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
	set cscopetag

	" check cscope for definition of a symbol before checking ctags: set to 1
	" if you want the reverse search order.
    set csto=0

	" add any cscope database in current directory
	if filereadable("cscope.out")
	" cs add cscope.out  
	" else add the database pointed to by environment variable 
	elseif $CSCOPE_DB != ""
	cs add $CSCOPE_DB
	endif

	" show msg when any other cscope db added
	set cscopeverbose  


	""""""""""""" My cscope/vim key mappings
	"
	" The following maps all invoke one of the following cscope search types:
	"
	"   's'   symbol: find all references to the token under cursor
	"   'g'   global: find global definition(s) of the token under cursor
	"   'c'   calls:  find all calls to the function name under cursor
	"   't'   text:   find all instances of the text under cursor
	"   'e'   egrep:  egrep search for the word under cursor
	"   'f'   file:   open the filename under cursor
	"   'i'   includes: find files that include the filename under cursor
	"   'd'   called: find functions that function under cursor calls
	"
	" Below are three sets of the maps: one set that just jumps to your
	" search result, one that splits the existing vim window horizontally and
	" diplays your search result in the new window, and one that does the same
	" thing, but does a vertical split instead (vim 6 only).
	"
	" I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
	" unlikely that you need their default mappings (CTRL-\'s default use is
	" as part of CTRL-\ CTRL-N typemap, which basically just does the same
	" thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
	" If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
	" of these maps to use other keys.  One likely candidate is 'CTRL-_'
	" (which also maps to CTRL-/, which is easier to type).  By default it is
	" used to switch between Hebrew and English keyboard mode.
	"
	" All of the maps involving the <cfile> macro use '^<cfile>$': this is so
	" that searches over '#include <time.h>" return only references to
	" 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
	" files that contain 'time.h' as part of their name).


	" To do the first type of search, hit 'CTRL-\', followed by one of the
	" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
	" search will be displayed in the current window.  You can use CTRL-T to
	" go back to where you were before the search.  
	"

	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

	nmap <F9>s :cs find s 
	nmap <F9>g :cs find g 
	nmap <F9>c :cs find c 
	nmap <F9>t :cs find t 
	nmap <F9>e :cs find e 
	nmap <F9>f :cs find f 
	nmap <F9>i :cs find i 
	nmap <F9>d :cs find d 


	" Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
	" makes the vim window split horizontally, with search result displayed in
	" the new window.
	"
	" (Note: earlier versions of vim may not have the :scs command, but it
	" can be simulated roughly via:
	"    nmap <F5>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

	nmap <F5>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
	nmap <F5>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
	nmap <F5>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
	nmap <F5>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
	nmap <F5>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
	nmap <F5>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
	nmap <F5>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
	nmap <F5>d :scs find d <C-R>=expand("<cword>")<CR><CR>	

	nmap <F8>s :scs find s 
	nmap <F8>g :scs find g 
	nmap <F8>c :scs find c 
	nmap <F8>t :scs find t 
	nmap <F8>e :scs find e 
	nmap <F8>f :scs find f 
	nmap <F8>i :scs find i 	
	nmap <F8>d :scs find d 

	
	" Hitting CTRL-space *twice* before the search type does a vertical 
	" split instead of a horizontal one (vim 6 and up only)
	"
	" (Note: you may wish to put a 'set splitright' in your .vimrc
	" if you prefer the new window on the right instead of the left

	nmap <F5><F5>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <F5><F5>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <F5><F5>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <F5><F5>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <F5><F5>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <F5><F5>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <F5><F5>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
	nmap <F5><F5>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


	nmap <F8><F8>s :vert scs find s 
	nmap <F8><F8>g :vert scs find g 
	nmap <F8><F8>c :vert scs find c 
	nmap <F8><F8>t :vert scs find t 
	nmap <F8><F8>e :vert scs find e 
	nmap <F8><F8>f :vert scs find f 
	nmap <F8><F8>i :vert scs find i 
	nmap <F8><F8>d :vert scs find d 

	""""""""""""" key map timeouts
	"
	" By default Vim will only wait 1 second for each keystroke in a mapping.
	" You may find that too short with the above typemaps.  If so, you should
	" either turn off mapping timeouts via 'notimeout'.
	"
	"set notimeout 
	"
	" Or, you can keep timeouts, by uncommenting the timeoutlen line below,
	" with your own personal favorite value (in milliseconds):
	"
	"set timeoutlen=4000
	"
	" Either way, since mapping timeout settings by default also set the
	" timeouts for multicharacter 'keys codes' (like <F1>), you should also
	" set ttimeout and ttimeoutlen: otherwise, you will experience strange
	" delays as vim waits for a keystroke after you hit ESC (it will be

	" waiting to see if the ESC is actually part of a key code like <F1>).
	"
	"set ttimeout 
	"
	" personally, I find a tenth of a second to work well for key code
	" timeouts. If you experience problems and have a slow terminal or network
	" connection, set it higher.  If you don't set ttimeoutlen, the value for
	" timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
	"
	"set ttimeoutlen=100

endif

"Cvim setting
filetype plugin on

"Neocomplache
" Use neocomplcache.
let g:neocomplcache_enable_at_startup=1

"Tagbar
nmap <F4> :TagbarToggle<CR>
let g:tagbar_width = 30 
autocmd VimEnter * nested :call tagbar#autoopen(1) 
let g:tagbar_left = 1    

"TagList
nmap <F3> :Tlist<CR>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"WinManager
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap <F6> :WMToggle<cr>

"Paste Toggle
set pastetoggle=<F7>
