
filetype off                  " required
set nocompatible              " be iMproved, required
set noswapfile
set backspace=indent,eol,start
set expandtab
set tabstop=4
set splitbelow
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
call plug#begin('~/.vim/plugged')
Plug 'jjo/vim-cue'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'Bekaboo/deadcolumn.nvim'
Plug 'olexsmir/gopher.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'towolf/vim-helm'
Plug 'tpope/vim-commentary'
" Plug 'shaunsingh/seoul256.nvim'
Plug 'APZelos/blamer.nvim'
Plug 'ray-x/go.nvim'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/seoul256.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
" Plug 'preservim/vim-markdown'
Plug 'vimwiki/vimwiki'
Plug 'morhetz/gruvbox'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'michal-h21/vim-zettel'
Plug 'LnL7/vim-nix'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'idris-hackers/idris-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'monkoose/fzf-hoogle.vim'

" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'mrcjkb/haskell-tools.nvim'

Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'lifepillar/vim-solarized8'
Plug 'akinsho/toggleterm.nvim'
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'lifepillar/vim-solarized8'
Plug 'sainnhe/everforest'
Plug 'tell-k/vim-autopep8'
Plug 'brentyi/isort.vim'
Plug 'junegunn/goyo.vim'
Plug 'ray-x/lsp_signature.nvim'
call plug#end()
set completeopt=menu,menuone,noselect,noinsert
filetype plugin indent on
set number
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
set nofoldenable
set autoread
let g:tex_conceal='abdmg'

autocmd BufNewFile,BufRead *.tpl  setfiletype helm

let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1

" autocmd FileType python
"         \ autocmd BufWritePost * Isort

" autocmd FileType python
"     \ autocmd BufWritePost * call SortImports()

" Initialize plugin system
let g:vi_markdown_math = 0

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
if !exists("g:syntax_on")
    syntax enable
endif
if (has('termguicolors'))
  set termguicolors
endif
" color seoul256
color gruvbox
let g:gruvbox_italic=1
" color seoul256-light
hi! Comment gui=italic
hi Normal guibg=NONE ctermbg=NONE
" hi Statement ctermfg=11 gui=italic guifg=#ffff60
" hi! link Identifier
" hi! Function gui=italic
" hi! Statement gui=italic
" hi pythonStatement gui=italic
" hi Keyword gui=italic
" hi Normal ctermbg=NONE
" highlight LspDiagnosticsDefaultError guifg=#895E5F
" hi LspDiagnosticsVirtualTextError guifg=#895E5F
" highlight LspDiagnosticsDefaultHint guifg=#D98660
" hi Pmenu guibg=#C7C5C7
set lcs+=space:·
set list
:highlight LineNr ctermbg=NONE guibg=NONE


lua << EOF
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'
local async = require "plenary.async"
local util = require('lspconfig/util')

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  completion = {
    autocomplete = false
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-q>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      floating_window = true,
      floating_window_above_cur_line = true,
      floating_window_off_x = 20,
      doc_lines = 10,
      hint_prefix = '👻 '
    }, bufnr)  -- Note: add in lsp client on-attach
end

-- TS setup
local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

-- Все далее по го спизжено с https://habr.com/ru/post/678298
nvim_lsp.gopls.setup({
  on_attach = on_attach,
  cmd = { 'gopls', 'serve' },
  filetypes = { 'go', 'go.mod' },
  root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    }
  }
})
-- golang format on save
vim.api.nvim_create_autocmd({'BufWritePre'}, {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format()
  end
})
-- golang sortimports
vim.api.nvim_create_autocmd({'BufWritePre'}, {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format()
  end
})
-- golang unused spaces remove
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup('TrimWhiteSpaceGrp', {})
vim.api.nvim_create_autocmd('BufWritePre', {
	group = TrimWhiteSpaceGrp,
  pattern = '*',
  command = '%s/\\s\\+$//e',
})

nvim_lsp.tsserver.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
        on_attach(client, bufnr)
    end,
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier
    },
    on_attach = on_attach
})

-- Stylelint format after save
require'lspconfig'.stylelint_lsp.setup{
  settings = {
    stylelintplus = {
      --autoFixOnSave = true,
      --autoFixOnFormat = true,
    }
  }
}


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'gopls', 'hls', 'dagger'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF




" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
nnoremap <silent> <Leader>bd :Bclose<CR>


map gn :bn<cr>
map gp :bp<cr>
map gw :Bclose<cr>

" set colorcolumn=79

" вывод подсказки линтера в окошке
nnoremap <silent> g? <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords


" let g:goyo_width=120
" let g:goyo_linenr=1
hi Conceal ctermbg=NONE guibg=NONE
hi htmlBold cterm=bold gui=bold
hi htmlItalic cterm=italic gui=italic
set expandtab
set tabstop=4
let g:blamer_enabled = 1

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
" Example config in Vim-Script

augroup LspGo
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'go-lang',
      \ 'cmd': {server_info->['gopls']},
      \ 'whitelist': ['go'],
      \ })
  autocmd FileType go setlocal omnifunc=lsp#complete
  "autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
  "autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
  "autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
augroup END

function! s:goyo_enter()
        set number
        set lcs+=space:·
        set list
        :highlight LineNr ctermbg=NONE guibg=NONE
endfunction

function! s:goyo_leave()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


if exists("g:neovide")
        set guifont=MonoLisa\ Custom:h12
        set guioptions-=r
        set colorcolumn=80
        set mouse=a
        " system clipboard
        nmap <c-c> "+y
        vmap <c-c> "+y
        nmap <c-v> "+p
        inoremap <c-v> <c-r>+
        cnoremap <c-v> <c-r>+
        " let g:neovide_input_use_logo=v:true
        let g:neovide_cursor_vfx_mode="railgun"
        set signcolumn
        autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
        " use <c-r> to insert original character without triggering things like auto-pairs
        " NOTE: some options enabled by env variables in launchctl:
        "
        " smooth scroll
        " launchctl setenv NEOVIDE_MULTIGRID true
        "
        " frameles with draggable
        " launchctl setenv NEOVIDE_FRAME buttonless
        " launchctl setenv NEOVIDE_FRAMELESS false
        "
        "
        "
        let g:transparency = 1.0
        let g:neovide_background_color = '#282828'.printf('%x', float2nr(255 * g:transparency))
        inoremap <c-r> <c-v>
        function! LightMode()
                "color onehalflight
                color solarized8_flat
                set background=light
                hi Conceal ctermbg=NONE guibg=NONE
                hi htmlBold gui=bold
                hi htmlItalic gui=italic
        endfunction

        function! DarkMode()
                "color monokai-bold
                color gruvbox
                set background=dark
                hi Conceal ctermbg=NONE guibg=NONE
                hi htmlBold gui=bold
                hi htmlItalic gui=italic
        endfunction

        function! HaskellMode()
                set background=light
                color onehalflight
                hi Conceal ctermbg=NONE guibg=NONE
                hi htmlBold gui=bold
                hi htmlItalic gui=italic
                set guifont=Latin\ Modern\ Mono:h14
        endfunction




        " au VimEnter * call goyo#execute(0, '96%x99')
        autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif


	"let g:gtk_nocache=[0x00000000, 0xfc00ffff, 0xf8000001, 0x78000001]
	"fullscreen"
	"color onehalflight
	"hi Conceal ctermbg=NONE guibg=NONE
    "set guifont=Latin\ Modern\ Mono\ Medium\ 14
        " if system('date +%H') >= 17 || system('date +%H') <= 7
        "         call DarkMode()
        " else
        "         call LightMode()
        " endif
     call DarkMode()



endif


