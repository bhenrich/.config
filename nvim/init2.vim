" --- Specify a directory for plugins (this is important) ---
" e.g. ~/.vim/plugged on Unix-like systems or
"      ~/vimfiles/plugged on Windows:
call plug#begin('~/.vim/plugged')

" --- Sensible defaults ---
Plug 'tpope/vim-sensible'

" --- Themes ---
Plug 'morhetz/gruvbox'


" --- Optional: Fun game to improve Vim skills ---
Plug 'ThePrimeagen/vim-be-good'

" --- Syntax highlighting ---
Plug 'vim-scripts/indentpython.vim'
Plug 'cespare/vim-toml'
Plug 'sheerun/vim-polyglot'

" --- Language Server Protocol (LSP) Client ---
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Optional: Snippet engine (if you use snippets)
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Optional: Nicer completion menu
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

" --- File Browser ---
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" --- Inline Diagnostics with nvim-lint ---
Plug 'mfussenegger/nvim-lint'

" --- Optional:  Status Line ---
Plug 'nvim-lualine/lualine.nvim'

" --- Optional:  Fuzzy finder ---
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

" --- Optional: Commenting ---
Plug 'numToStr/Comment.nvim'
" BROKEN Plug 'JoosepAlviste/nvim-ts-context-cmt'

call plug#end()

" --- Basic Settings ---
set number           " Show line numbers
set relativenumber   " Show relative line numbers
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartcase
set ignorecase
set hlsearch
set incsearch
set termguicolors    " Enable true colors support
set background=dark   " Use a dark background
set scrolloff=8
set signcolumn=yes
set noerrorbells
set noswapfile
set undodir=~/.vim/undodir
set undofile
set updatetime=50
set completeopt=menu,menuone,noselect

colorscheme gruvbox

" --- Filetype-specific settings ---
augroup filetype_settings
  autocmd!
  autocmd FileType rust setlocal sw=4 ts=4 sts=0
augroup END

" --- Keymaps ---
let mapleader = " "
nnoremap <leader>pv :NvimTreeToggle<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fm <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fM <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>fd <cmd>Telescope lsp_references<cr>
nnoremap <leader>fc <cmd>Telescope lsp_definitions<cr>

" --- Completion config ---
lua << EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
  }
})
EOF

" --- LSP config ---
lua << EOF
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.rust_analyzer.setup{
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy"
      },
    }
  }
}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
EOF

" --- Lint config ---
lua << EOF
require('lint').linters_by_ft = {
  rust = {'rust_analyzer'},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
EOF

" --- Comment config ---
lua << EOF
require('Comment').setup()
EOF

" --- Lualine config ---
lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
EOF

" --- Nvim-tree config ---
lua << EOF
require("nvim-tree").setup {}
EOF
