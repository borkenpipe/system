execute pathogen#infect()
map <C-E><C-E> :Error<RETURN>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Better :sign interface symbols
" http://www.fileformat.info/info/unicode/category/So/list.htm
" let g:syntastic_error_symbol = '☠'
" let g:syntastic_warning_symbol = '🦀'
" let g:syntastic_style_error_symbol = '🍺'
" let g:syntastic_style_warning_symbol = '🙈'
" Syntastic
let g:syntastic_error_symbol = '✗✗'
let g:syntastic_style_error_symbol = '✠✠'
let g:syntastic_warning_symbol = '∆∆'
let g:syntastic_style_warning_symbol = '≈≈'

"let g:syntastic_python_checkers=['flake8']
"let g:syntastic_python_flake8_args = '--ignore="E501"' " ignore long lines
"au BufRead,BufNewFile *.json set filetype=json
"Broken pipes can happen anywhere at any time, usually when you least expect it.
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_yaml_checkers=['yamllint']
let g:syntastic_yaml_args = "-c ~/.yamllint.yml"
let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_python_pylint_args = "--errors-only"
let g:syntastic_sh_checkers = ['shellcheck']
"let g:syntastic_sh_shellcheck_args = "-x -e SC2086 -e SC1090"

"call pathogen#runtime_append_all_bundles()

"setlocal spell spelllang=en_us
set spellfile=~/etc/en.utf-8.spl.add

""""""""""""""""""""""""   BASICS
set nocompatible

""""""""""""""""""""""""   FUZZY FINDING
" ** is special, search subdir and subdir of them
set path+=**

""""""""""""""""""""""""   CODE

filetype plugin indent on
syn on
set smartindent
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,ps,t0,c3,+s,(s2,us,)20,*30,gs,hs
set expandtab
set textwidth=400
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
"" OFFset pastetoggle=
"" OFFnnoremap :set invpaste paste?=
set pastetoggle=<C-p><C-p>
set showmode

""""""""""""""""""""""""   FILETYPE TABS
" specifics based on file type
" autocmd FileType yml setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType python setlocal shiftwidth=4 softtabstop=4

"""""""""""""""""""""" File browsing 
let g:netrw_banner = 0
let g:netrw_liststyle = 3   " 3 is tree style
let g:netrw_browse_split = 4
" 1 - open files in a new horizontal split
" 2 - open files in a new vertical split
" 3 - open files in a new tab
" 4 - open in previous window
let g:netrw_altv = 1        " open splits to the right
let g:netrw_winsize = 25
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide=.=',\(^\|\s\s\)\zs\.\S\+'

" CSCOPE
set scs

" Tag List plugin
autocmd BufWritePost *.c :TlistUpdate

""""""""""""""""""""""""   SEARCHING
set hlsearch
set incsearch
set ignorecase

""""""""""""""""""""""""   HACKING
map <F8> :%s!xxd
map <F9> :%s!xxd -r

""""""""""""""""""""""""   VISIBILITY
set bg=dark
map <F10> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>
map <F11> :nohls<CR>

autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))
set cursorline
set nu

augroup filetypedetect
augroup END

""""""""""""""""""""""""   MOUSE
"set mouse=a

""""""""""""""""""""""""   SPLIT WINS
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0

map <C-L> <C-W>l
map <C-H> <C-W>h


""""""""""""""""""""""""   USABILITY
"make my tab complete like bash damn it!
set wildmode=list:longest  " When autocompleting things, do it like the shell
set wildmenu               " Autocomplete things on the menu?

command Fu ':w !sudo tee % > /dev/null'
"map :w !sudo tee % > /dev/null

" Grepper https://github.com/mhinz/vim-grepper/wiki/using-the-prompt
nnoremap <leader>g :Grepper<cr>
let g:grepper = { 'next_tool': '<leader>g' }

nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>G :Grepper -tool ag<cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Optional. The default behaviour should work for most users.
let g:grepper               = {}
let g:grepper.tools         = ['git', 'ag', 'rg']
let g:grepper.jump          = 1
let g:grepper.next_tool     = '<leader>g'
let g:grepper.simple_prompt = 1
let g:grepper.quickfix      = 0

function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
