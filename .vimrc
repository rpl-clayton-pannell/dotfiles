set nocompatible              " be iMproved, required
set backspace=indent,eol,start
filetype off                  " required
"" set the runtime path to include Vundle and initialize
"if has("unix")
"    set shell=/bin/bash
"    set rtp+=~/.vim/bundle/vundle.vim
"    call vundle#begin('$HOME/.vim/bundle/')
"elseif has("win32")
"    set rtp+=$HOME/vimfiles/bundle/vundle.vim
"    call vundle#begin('$HOME/vimfiles/bundle/')
"endif
"
"" alternatively, pass a path where Vundle should install plugins
""call vundle#begin('~/some/path/here')
"
"" let Vundle manage Vundle, required
"Plugin 'VundleVim/vundle.vim'

"Autoinstall VIM-Plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"Plugins
Plug 'tmhedberg/SimpylFold'
"Plug 'vim-scripts/indentpython.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'} "New completion
"Plug 'vim-syntastic/syntastic' "Syntax checking
Plug 'altercation/vim-colors-solarized' "Solarized colorscheme
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim' "CTRL+P to search
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'rust-lang/rust.vim', {'for': 'rust'} "Rust checker
Plug 'psf/black', { 'for': 'python', 'branch': 'stable' } "Black python formater
Plug 'gu-fan/riv.vim' "ReStructuredText add-in
"Plugin 'morhetz/gruvbox'    "Better terminal mode than solarized
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'nvie/vim-flake8' "PEP8 checking
"Plugin 'gu-fan/InstantRst' "Instant RST renderer
Plug 'igankevich/mesonic'  "Meson highlighting/integration
Plug 'tpope/vim-fugitive' "Git integration
Plug 'neovim/nvim-lspconfig' "nvim only
Plug 'hrsh7th/nvim-cmp'  "nvim completion
Plug 'hrsh7th/cmp-nvim-lsp'  "nvim completion
Plug 'hrsh7th/cmp-buffer'  "nvim completion
Plug 'hrsh7th/cmp-path'  "nvim completion
Plug 'hrsh7th/cmp-cmdline'  "nvim completion
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}  "AST based syntax highlighting
"Plug 'creativenull/efmls-configs-nvim', {'tag': 'v1.*' } " efm-langserver preset configs.

call plug#end()

"Set Line numbering and some formatting happiness
set nu
set wrap
set linebreak
set showbreak=+++
au BufRead *
    \ let &numberwidth=(float2nr(log10(line("$"))) + 2) |
    \ if has('gui_running') |
    \    let &columns=&numberwidth +126 |
    \ endif

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" visual up/down so that wrapped text won't be skipped
nnoremap j gj
nnoremap k gk

"Map Make to F5
map <F5> :make<CR>

"Map F7 to Toggle between using gdb and arm-none-eabi-gdb for debugging
nnoremap <silent> <F7> :call ToggleTermDebugGDB()<CR>

function! ToggleTermDebugGDB()
	if exists("g:termdebugger")
		unlet g:termdebugger
		echo "Using System gdb"
	else
		let g:termdebugger = "arm-none-eabi-gdb"
		echo "Using arm-none-eabi-gdb"
	endif
endfunction

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

"see docstrings for folded code
let g:SimpylFold_docstring_preview=1

"Rust formatting:
au BufNewFile,BufRead *.rs
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix |
    \ setlocal encoding=utf-8 |
    \ setlocal nu |
    \ setlocal textwidth=79 |
    \ setlocal colorcolumn=80 |
    \ highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

"C\C++ formatting (LLVM):
au BufNewFile,BufRead *.c,*.h,*.cpp,*.hpp
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix |
    \ setlocal encoding=utf-8 |
    \ setlocal nu |
    \ setlocal colorcolumn=80 |
    \ if !exists(":TermDebug") |
    \     packadd termdebug |
    \ endif |
    \ highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Run clang-format when saving a C/C++ file.
" autocmd BufWritePre *.c,*.h,*.cpp,*.hpp execute ':Format'
" autocmd BufWritePre *.c,*.h,*.cpp,*.hpp lua vim.lsp.buf.format()

"SystemVerilog: Conform to google? formatting
au BufNewFile,BufRead *.v,*.sv
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix |
    \ setlocal encoding=utf-8 |
    \ setlocal nu

"Asm formatting
au BufNewFile,BufRead *.asm,*.S,*.s
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal noexpandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix |
    \ setlocal encoding=utf-8 |
    \ setlocal nu |
    \ setlocal colorcolumn=80 |
    \ if !exists(":TermDebug") |
    \     packadd termdebug |
    \ endif |
    \ highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

"PYTHON: conform to PEP8 formatting
au BufNewFile,BufRead *.py,*.pyx,*.kv,*.enaml
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix |
    \ setlocal encoding=utf-8 |
    \ setlocal nu |
    \ wincmd t |
    \     if exists("b:NERDTree") && has("gui_running")  |
    \ let &columns=(&numberwidth+79+NERDTreeWinSize+1) |
    \ elseif has("gui_running") |
    \     let &columns=(&numberwidth+79) |
    \ endif |
    \ wincmd p |
    \ setlocal colorcolumn=80 |
    \ highlight ColorColumn ctermbg=lightgrey guibg=lightgrey |
    \ setlocal makeprg=python\ %:S |
    \ let g:black_linelength=79 |
    \ setlocal autowrite |
    \ let g:syntastic_python_python_exec = 'python3'

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.pyx,*.kv,*.c,*.h match BadWhitespace /\s\+$/
" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

"" Run black when saving a python file.
" autocmd BufWritePre *.py execute ':Black'

" Run darker to run Black on changes when saving a python file.
autocmd BufWritePost *.py silent execute ':!darker %'


"Add formatting for javascript, html, and css
" Now in ~/.vim/ftplugin/html.vim
" au BufNewFile,BufRead *.js, *.html, *.css
"     \ setlocal tabstop=4 |
"     \ setlocal softtabstop=4 |
"     \ setlocal shiftwidth=4 |
"     \ setlocal textwidth=79 |
"     \ setlocal expandtab |
"     \ setlocal autoindent |
"     \ setlocal fileformat=unix |
"     \ setlocal encoding=utf-8 |
"     \ setlocal nu |

"UTF-8 Encoding
"set encoding=utf-8

" "COC customizations
" set hidden  "hides changed files instead of closing, required for coc
" set updatetime=300 "Faster interaction
" set shortmess+=c  "don't pass mesages to |ins_completion-menu|.
" set signcolumn=yes  "prevents shifting text w/ diagnostics
" 
" function! s:check_back_space() abort
" 	let col = col('.') - 1
" 	return !col || getline('.')[col - 1] =~# '\s'
" endfunction
" 
" "use <c-space> to trigger completion
" inoremap <silent><expr> <c-space> coc#refresh()
" 
" "use <cr> to confirm completion, '<C-g>u means break undo chain at
" "current position
" if exists('*complete_info')
" 	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
" 	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif
" 
" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" 
" 
" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" 
" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" 
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
" 
" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
" 
" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
" 
" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
" 
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
" 
" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" 
" " Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)
" 
" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)
" 
" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)
" 
" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')
" 
" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" 
" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" 
" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" 
" " Mappings using CoCList:
" " Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"YouCompleteMe Customizations
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"map <leader>d :YcmCompleter GetDoc<CR>
""Use virtualenv python
"let g:ycm_python_binary_path = 'python'
"let g:ycm_server_python_interpreter = '/usr/bin/python3'
""let g:ycm_server_python_interpreter = '/usr/bin/python2'
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

"RustStuff
"Point YCM to rust src (installed from fedora pkg rust-src
"let g:ycm_rust_src_path = '~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
"let g:ycm_rust_src_path = '~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
"AutoFmt on save
let g:rustfmt_autosave = 1


"python with virtualenv support
"python3 << EOF
"import os
"import subprocess
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin', 'activate_this.py')
"  # print(activate_this)
"  subprocess.call('source %s' % activate_this, shell=True)
"  #execfile(activate_this, dict(__file__=activate_this))
"EOF

"Enable Syntax Highlighting for python
let python_highlight_all=1
syntax on

"change colorscheme between GUI and console mode
if has('gui_running')
  set background=dark
  colorscheme solarized
  set guifont=Hack\ 10
  ":h10:cANSI:qDRAFT
else
  "set background=dark
  "colorscheme solarized
  "set termguicolors
endif

"close if nerdtree is the last buffer open
au BufEnter *
    \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |
    \ q | 
    \ endif
"This should add 32 columns whenever NERDTree is turned on
"au BufNew FileType NERDTree let &columns=&columns+NERDTreeWinSize+1
"au BufWinLeave && FileType nerdtree let &columns=&columns-NERDTreeWinSize-1

"Automate changing buffer's local director (lcd) to the file's directory
"This makes :make and !<command> % work as expected
au BufEnter * silent! lcd %:p:h

"Enable Syntastic for python
"let g:syntastic_python_checkers = ['flake8']
"set statusline+=%#warnings#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0

"Enable Syntastic for javascript
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'

"Enable Syntastic for html
"let g:syntastic_html_checkers = ['w3']
"Doesn't work for some reason. will figure out later, hopefully.

"Enable Syntastic for cpp
let g:syntastic_cpp_checkers = ['clang-tidy']
let g:syntastic_cpp_clang_tidy_post_args = ""
