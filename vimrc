" vim: foldmethod=marker

" options {{{
set noundofile nobackup nowritebackup number
if has("win32")
    set guifont=JetBrains_Mono:h10:cANSI:qDRAFT
else
    set guifont=JetBrains\ Mono\ 10
endif
"set guifont=Consolas:h11:cANSI:qDRAFT

syn on
"so $VIMRUNTIME/mswin.vim

"let g:zzenburn_high_contrast=1
colorscheme zenburn

set spell
set ruler
set tabstop=8
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set cindent 
"set clipboard=unnamed,autoselect
"set guioptions+=a
set guioptions-=tT
set ignorecase
set smartcase
set incsearch
set relativenumber
set showmatch
set scrolloff=5

set linebreak
set showbreak=>>>\ 
" set showbreak=↳    " some sort of rendering issue
set breakindent
" consider breakindentopt

if !has('nvim')
    set renderoptions=type:directx
endif

if has('unix')
    set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~}
endif

"set viminfo+=rC:\\Users\\alopresto\\AppData\\Local\\Temp
set viminfo+=r~\\AppData\\Local\\Temp

" set shell=powershell.exe
" set shellcmdflag=-NoProfile\ -NoLogo\ -NonInteractive\ -Command
" set shellpipe=|
" set shellredir=>
" }}}

" Plugin independent mappings {{{

"nnoremap ; i<C-R> =strftime("%Y-%m-%d")<CR><Esc>

"Stolen from mswin.vim, the ones I want and skipping the others

    nnoremap <C-V> "+gP
    inoremap <C-V> <C-r><C-r>+
     noremap <C-Q> <C-V>
    vnoremap <C-C> "+y

nnoremap <Space> <C-F>

"Use tab and shift-tab to indent/unindent. https://vim.fandom.com/wiki/Shifting_blocks_visually
" nnoremap <Tab> >>_
" nnoremap <S-Tab> <<_
" inoremap <S-Tab> <C-D>
" vnoremap <Tab> >gv
" vnoremap <S-Tab> <gv

"Force safer pastes
inoremap <C-r> <C-r><C-r>
cnoremap <C-r> <C-r><C-r>

inoremap <C-l> <C-o><C-l>

"make <CR> save unsaved changes, but not in a command window
nnoremap <CR> :<C-U>up<CR>
au CmdwinEnter * nnoremap <buffer> <CR> <CR>

:cnoremap <C-N> <Down>
:cnoremap <C-P> <Up>
"Long-term, I should probably remap <Up>/<Down> to <C-N>/<C-P>'s functionality, but for right now, I'm just noop-ing them so I break the habit of reaching for them.

":cnoremap <Up> <Nop>
":cnoremap <Down> <Nop>

xnoremap il g_o^
onoremap il :silent normal vil<CR>
xnoremap al $o0
onoremap al :silent normal val<CR>

xnoremap i% GoggV
onoremap i% :silent normal vi%<CR>

" last change pseudo-text objects
" " ik ak
xnoremap ik `]o`[
onoremap ik :<C-u>normal vik<CR>
onoremap ak :<C-u>normal vikV<CR>

nnoremap <leader>s q:i%s//g<Left><Left>
vnoremap <leader>s :s/\%V\%V//g<Left><Left><Left><Left><Left><Left>

cnoremap <expr> / getcmdline()[getcmdpos()-1:getcmdpos()+2] ==# '\%V/' ? "<Right><Right><Right><Right>" : "/"

nnoremap <leader><space> /&nbsp;<cr>cgn <esc>

" nnoremap : q:i
" vnoremap : q:i

inoremap <expr> <c-y> pumvisible() ? "\<c-y>" : matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" }}}

" plugin pre-configuration {{{
let g:surround_no_mappings = 1
" }}}

" plugins {{{
call plug#begin('~/vimfiles/plugged')

" Plug 'wellle/context.vim'
" Plug 'vim-scripts/dbext.vim'
Plug 'skammer/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf',  { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'tmsvg/pear-tree'
" Plug 'StanAngeloff/php.vim'
Plug 'unblevable/quick-scope'
Plug 'AndrewRadev/sideways.vim'
Plug 'wellle/targets.vim'
Plug 'tomtom/tcomment_vim'
Plug 'markonm/traces.vim'
Plug 'jesseleite/vim-agriculture'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'tommcdo/vim-exchange'
if !has('nvim')
    Plug 'axlebedev/footprints'
endif
Plug 'andymass/vim-matchup'
Plug 'konfekt/vim-peekaboo'
Plug 'PProvost/vim-ps1'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-sensible'
" Plug 'mhinz/vim-signify'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
" Reorder function arguments &c
Plug 'kurkale6ka/vim-swap'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-syntax'
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'tpope/vim-unimpaired'
" Plug 'RobertAudi/YankRing.vim'
" Plug 'michal-h21/vim-zettel'
" Plug 'vimwiki/vimwiki'

call plug#end()

" }}}

" Airline {{{
"let g:airline_theme='zenburn'
let g:airline_theme='distinguished'
"let g:airline_theme='sol'
let g:airline_powerline_fonts=1
"let g:airline#extensions#whitespace#checks = [ 'conflicts' ]
let g:airline_detect_spell=0 
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
let g:airline#extensions#whitespace#enabled = 0
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.linenr = ''
" }}}
" Pear tree {{{
" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_ft_disabled=['vimwiki']
" }}}

let g:peekaboo_delay=300
let g:peekaboo_special=['"','+', '-']

" I like vim-sandwich with vim-surround mappings
runtime macros/sandwich/keymap/surround.vim
" But I use vim-surround's ds until sandwich fixes https://github.com/machakann/vim-sandwich/issues/107
nmap ds  <Plug>Dsurround

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" VimWiki, Zettel {{{
let g:vimwiki_list = [{'path': '~/Google Drive/vimwiki', 'auto_toc': 1, 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_use_mouse = 1
let g:vimwiki_folding = 'expr'
let g:vimwiki_auto_chdir = 1

let g:zettel_options = [{"front_matter" : {"tags" : ""}, "template" :  "~/Google Drive/vimwiki/template.tpl"}]
let g:zettel_format = '%Y%m%d%H%M%S'
" let g:zettel_fzf_command = "rg"
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "

imap <silent> [[ [[<esc><Plug>ZettelSearchMap
"nmap T <Plug>ZettelYankNameMap
nnoremap <leader>vt :VimwikiSearchTags<space>
nnoremap <leader>vs :VimwikiSearch<space>
nnoremap <leader>gt :VimwikiRebuildTags!<cr>:VimwikiGenerateTagLinks<cr><c-l>
nnoremap <leader>zl :ZettelSearch<cr>
" nnoremap <leader>zn :ZettelNew<cr><cr>:4d<cr>:w<cr>ggA
nnoremap <leader>zn :ZettelNew<cr>
nnoremap <leader>bl :VimwikiBacklinks<cr>
" }}}

let g:yankring_manage_numbered_reg = 1
let g:yankring_min_element_length = 2

" nmap instead of nnoremap because of yankring
nmap Y y$

command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case '.shellescape(<q-args>), 1, fzf#vim#with_preview({ 'options': '--color hl:123,hl+:222'}), <bang>0)

if !has('nvim')
    call footprints#SetColor('#606080')
endif

" EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Sideways mappings {{{
nnoremap <, :SidewaysLeft<cr>
nnoremap >, :SidewaysRight<cr>
nnoremap [, :SidewaysJumpLeft<cr>
nnoremap ], :SidewaysJumpRight<cr>

nmap <leader>si <Plug>SidewaysArgumentInsertBefore
nmap <leader>sa <Plug>SidewaysArgumentAppendAfter
nmap <leader>sI <Plug>SidewaysArgumentInsertFirst
nmap <leader>sA <Plug>SidewaysArgumentAppendLast
" }}}

"Make :W do the same as :w, since I keep mistyping it anyway.
command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! Toad !start explorer /select,%
command! -range=% Y <line1>,<line2>yank *

function! CopyFormatted(line1, line2)
    execute a:line1 . "," . a:line2 . "TOhtml"
    g/<!-- vim: set foldmethod=manual : -->/d
    %yank *
    !start /min powershell -noprofile "gcb | scb -as"
    bwipeout!
endfunction

command! -range=% HtmlClip silent call CopyFormatted(<line1>,<line2>)

function! WikiCleanup(bang) range
    silent! execute a:firstline . "," . a:lastline .  's!</\?span\>\_.\{-}>!!g'
    silent! execute a:firstline . "," . a:lastline .  's!<sup>\_.\{-}</sup>!!g'
    silent! execute a:firstline . "," . a:lastline .  's/&nbsp;/ /g'
    silent! execute a:firstline . "," . a:lastline .  's!</div>\_s*<div>!<p>!g'
    if a:bang
        silent! execute a:firstline . "," . a:lastline .  's!</\?a\>\_.\{-}>!!g'
    endif
endfunction

command! -range=% -bang WikiCleanup <line1>,<line2>call WikiCleanup(<bang>0)

nnoremap <F4> :WikiCleanup!<cr>

if has('win32')
    "Start maximized
    au GUIEnter * simalt ~x
endif

" Change to relative line numbers in normal mode and in insert mode use absolute line numbers
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * setlocal relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * setlocal norelativenumber
augroup END

"augroup AutoSaveFolds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent loadview
"augroup END
