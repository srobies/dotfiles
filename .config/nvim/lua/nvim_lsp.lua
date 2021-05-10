vim.cmd 'packadd paq-nvim'         -- Load package local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function0
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function
paq{'savq/paq-nvim', opt=true}     -- Let Paq manage itself

-- Plugin testing
paq 'windwp/nvim-autopairs'
paq 'glepnir/lspsaga.nvim'
paq 'neovim/nvim-lspconfig'
paq 'hrsh7th/nvim-compe'
paq 'hrsh7th/vim-vsnip'
paq 'alexaandru/nvim-lspupdate'
paq 'rafamadriz/friendly-snippets'
paq 'andweeb/presence.nvim'
paq 'christoomey/vim-tmux-navigator'
paq 'tversteeg/registers.nvim'
paq 'lewis6991/gitsigns.nvim'
paq 'kevinhwang91/nvim-bqf'
paq 'kyazdani42/nvim-tree.lua'
paq 'mfussenegger/nvim-dap'
paq 'b3nj5m1n/kommentary'
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'
paq 'glepnir/zephyr-nvim'
paq 'lervag/vimtex'
paq 'tpope/vim-repeat'
paq 'justinmk/vim-sneak'
paq 'ledger/vim-ledger'
paq 'nvim-treesitter/nvim-treesitter'
paq 'akinsho/nvim-toggleterm.lua'
-- -- paq 'puremourning/vimspector'
paq {'lukas-reineke/indent-blankline.nvim', branch='lua'}
paq 'mbbill/undotree'
paq 'tpope/vim-fugitive'
paq 'glepnir/galaxyline.nvim'
paq 'kyazdani42/nvim-web-devicons'

require('nvim-autopairs').setup()
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end


remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

require('nvim-treesitter.configs').setup {
    autopairs = {enable = true}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
    'diagnostic',
  }
}

require'lspconfig'.pyright.setup{
    capabilities = capabilities,
}
require'lspconfig'.clangd.setup{
    capabilities = capabilities,
}
require'lspconfig'.bashls.setup{
    capabilities = capabilities,
}
require'lspconfig'.texlab.setup{
    capabilities = capabilities,
}

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "clangd", "bashls", "texlab" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = { enable = true },
}

require('compe').setup{
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local saga = require 'lspsaga'
saga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    infor_sign = '',
    finder_action_keys = {
      open = 'o', vsplit = '|',split = '-',quit = {'q', '<esc>'}, scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    },
    code_action_keys = {
      quit = {'q', '<Esc>'}, exec = '<CR>'
    },
    rename_action_keys = {
      quit = {'<C-c>', '<Esc>'}, exec = '<CR>'  -- quit can be a table
    },
}

require('toggleterm').setup{
    open_mapping = [[<C-t>]]
}

require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})

require('gitsigns').setup{
    numhl = true,
    -- linehl = true
}

-- dap config
local dap = require('dap')
dap.adapters.cpp = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode', -- my binary was called 'lldb-vscode-11'
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}
vim.cmd [[
    command! -complete=file -nargs=* DebugC lua require "my_debug".start_c_debugger({<f-args>}, "gdb")
]]
vim.cmd [[
    command! -complete=file -nargs=* DebugRust lua require "my_debug".start_c_debugger({<f-args>}, "gdb", "rust-gdb")
]]


local gl = require('galaxyline')
local gls = gl.section
local io = require('io')
local string = require('string')

local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef';
  red = '#ec5f67';
}
local mode_color = function()
    local mode_colors = {
        n = colors.green,
        i = colors.blue,
        c = colors.cyan,
        V = colors.violet,
        [''] = colors.violet,
        v = colors.violet,
        R = colors.red,
        t = colors.blue
    }
    if mode_colors[vim.fn.mode()] ~= nil then
        return mode_colors[vim.fn.mode()]
    else
        print(vim.fn.mode())
        return colors.violet
    end
end

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local python_venv = function()
    local handle = io.popen("echo \"$VIRTUAL_ENV\"")
    if handle == nil then
        return
    else
        local fullPath = handle:read("*a")
        handle:close()
        local venvName = string.gsub(fullPath, "/.*/", "")
        local output = string.gsub(venvName, "%c", "")
        if output ~= "" then
            return "venv:" .. output
        else
            return ""
        end
    end
end

local python_check = function ()
    local filetype = vim.bo.filetype
    if string.match(filetype, 'python') ~= nil then
        return true
    end
    return false
end

gls.left[1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = 'NORMAL',
                i = 'INSERT',
                c = 'COMMAND',
                v = 'VISUAL',
                V = 'V-LINE',
                [''] = 'VISUAL',
                R = 'REPLACE',
                t = 'TERMINAL',
                s = 'SELECT',
                S = 'S-LINE'
            }
            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
            if alias[vim.fn.mode()] ~= nil then
                return '  ' .. alias[vim.fn.mode()] .. ' '
            else
                return '  V-BLOCK '
            end
        end,
        highlight = {colors.bg,'bold'},
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
  },
}
gls.left[2] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
}

gls.left[3] = {
  FileName = {
    provider = {'FileName'},
    condition = buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.left[4] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[5] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
}

gls.left[6] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan,colors.bg},
  }
}

gls.left[7] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.right[1] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    separator = '',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[2] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    -- separator = '',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[3] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg},
  }
}
gls.right[4] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '柳',
    separator_highlight = {'NONE',colors.bg},
    highlight= {colors.orange,colors.bg},
  }
}
gls.right[5] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = ' ',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.red,colors.bg},
  }
}

gls.right[6] = {
  LineInfo = {
    provider = 'LineColumn',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg},
  },
}

gls.right[7] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg,'bold'},
  }
}

gls.right[8] = {
    PythonVenv = {
        provider = python_venv,
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
        condition = python_check,
        highlight = {colors.fg, colors.bg, "bold"}
    }
}

gls.right[9] = {
  FileSize = {
    provider = 'FileSize',
    condition = buffer_not_empty,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.right[10] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg}
    }
}
gls.right[11] = {
  FileEncode = {
    provider = 'FileEncode',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.cyan,colors.bg,'bold'}
  }
}

gls.right[12] = {
  FileFormat = {
    provider = 'FileFormat',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.cyan,colors.bg,'bold'}
  }
}

-- gls.short_line_left[1] = {
--     ViMode = {
--         provider = function()
--             local alias = {
--                 n = 'NORMAL',
--                 i = 'INSERT',
--                 c = 'COMMAND',
--                 v = 'VISUAL',
--                 V = 'V-LINE',
--                 [''] = 'VISUAL',
--                 R = 'REPLACE',
--                 t = 'TERMINAL',
--                 s = 'SELECT',
--                 S = 'S-LINE'
--             }
--             vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
--             if alias[vim.fn.mode()] ~= nil then
--                 return '  ' .. alias[vim.fn.mode()] .. ' '
--             else
--                 return '  V-BLOCK '
--             end
--         end,
--         highlight = {colors.bg,'bold'},
--         separator = ' '
--   },
-- }
gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider = function ()
      local fileinfo = require('galaxyline.provider_fileinfo')
      local fname = fileinfo.get_current_file_name()
      for _,v in ipairs(gl.short_line_list) do
        if v == vim.bo.filetype then
          return ''
        end
      end
      return fname
    end,
    condition = buffer_not_empty,
    highlight = {colors.white,colors.bg,'bold'}
  }
}
