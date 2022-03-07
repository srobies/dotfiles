require("dapui").setup()
-- small step for vimkind
local dap = require"dap"
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= "" then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: '))
      assert(val, "Please provide a port number")
      return val
    end,
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host, port = config.port})
end
-- cmp config
local cmp = require('cmp')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"]() == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
        })
    },
    sources = {
      { name = 'nvim_lsp'},
      { name = 'nvim_lua'},
      { name = 'vsnip' },
      { name = 'buffer' },
      { name = 'treesitter' },
      { name = 'omni' },
      { name = 'path'},
      { name = 'latex_symbols' },
      { name = 'orgmode' },
    },
    formatting = {
      format = function(entry, vim_item)
        local prsnt, lspkind = pcall(require, "lspkind")
        if not prsnt then
        vim_item.kind = string.format('%s', vim_item.kind) -- This concatonates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
          vsnip = '[vsnip]',
          buffer = "[Buffer]",
          treesitter = '[Treesitter]',
          omni = '[Omni]',
          path = '[Path]',
          latex_symbols = "[LaTeX]",
          orgmode = '[Org]'
        })[entry.source.name]
        return vim_item
        else
          return lspkind.cmp_format()
        end
      end
  },
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '{' } }))

-- orgmode config
require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}
require('orgmode').setup{
    org_agenda_file = '~/Dropbox/org/*',
    org_default_notes_file = '~/Dropbox/org/school.org',
}
require("org-bullets").setup {
    symbols = { "◉", "○", "✸", "✿" }
}
-- nvim-autopairs config
_G.MUtils= {}
local npairs = require('nvim-autopairs')
npairs.setup({
    check_ts = true,
    enable_check_bracket_line = true,
    fastwrap = {}
})
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
npairs.remove_rule('`')

-- IndentBlankLine config
require('indent_blankline').setup {
  char = '▏',
  context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'},
  buftype_exclude = {"terminal", 'help'},
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = true,
}
-- dap config
-- local dap = require('dap')
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

dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, {
    continue = {'.continue', '.c', 'c', 'continue'},
    next_ = {'.next', '.n', 'n', 'next'},
    back = {'.back', '.b', 'b', 'back'},
    reverse_continue = {'.reverse-continue', '.rc', 'rc'},
    into = {'.into', 'step', 's'},
    into_target = {'.into_target'},
    out = {'.out', 'finish', 'fin'},
    scopes = {'.scopes'},
    threads = {'.threads'},
    frames = {'.frames'},
    exit = {'exit', '.exit'},
    up = {'.up', 'up'},
    down = {'.down', 'down'},
    goto_ = {'.goto', 'until'},
    capabilities = {'.capabilities'},
    -- add your own commands
})

local windline = require('windline')
local b_components = require('windline.components.basic')
local state = _G.WindLine.state

local lsp_comps = require('windline.components.lsp')
local git_comps = require('windline.components.git')

local hl_list = {
    Black = { 'white', 'black' },
    White = { 'black', 'white' },
    Inactive = { 'InactiveFg', 'InactiveBg' },
    Active = { 'ActiveFg', 'ActiveBg' },
}
local basic = {}

local breakpoint_width = 90
basic.divider = { b_components.divider, '' }
basic.bg = { ' ', 'StatusLine' }

basic.vi_mode = {
    name = 'vi_mode',
    hl_colors = {
        Normal = { 'black', 'red', 'bold' },
        Insert = { 'black', 'green', 'bold' },
        Visual = { 'black', 'yellow', 'bold' },
        Replace = { 'black', 'blue_light', 'bold' },
        Command = { 'black', 'magenta', 'bold' },
    },
    text = function(_, _, width)
        if width > breakpoint_width then
            return { { " " .. state.mode[1] .. " ", state.mode[2] } }
        else
            local mode_string = state.mode[1]
            return { { " " .. mode_string.sub(mode_string, 1, 1) .. " ", state.mode[2] } }
        end
    end,
}

basic.lsp_diagnos = {
    name = 'diagnostic',
    hl_colors = {
        yellow = { 'yellow', 'black' },
        red = { 'red', 'black' },
        blue = { 'blue', 'black' },
        black = { 'black', 'black' },
    },
    width = breakpoint_width,
    text = function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {
                { ' ', 'red' },
                { lsp_comps.lsp_error({ format = ' %s', show_zero = true }), 'red' },
                { lsp_comps.lsp_warning({ format = '  %s', show_zero = true }), 'yellow' },
                { lsp_comps.lsp_hint({ format = '  %s', show_zero = true }), 'blue' },
            }
        else
            return {{" ", 'black'}}
        end
    end
}
basic.file = {
    name = 'file',
    hl_colors = {
        default = hl_list.Black,
        white = { 'white', 'black' },
        magenta = { 'magenta', 'black' },
    },
    text = function(_, _, width)
        if width > breakpoint_width then
            return {
                { b_components.cache_file_name('[No Name]', 'unique'), 'magenta' },
                { b_components.file_modified(' '), 'magenta' },
                { b_components.cache_file_size(), 'default' },
                { b_components.line_col_lua, 'white' },
                { b_components.progress_lua, '' },
                { ' ', '' },
            }
        else
            return {
                { b_components.cache_file_size(), 'default' },
                { ' ', '' },
                { b_components.cache_file_name('[No Name]', 'unique'), 'magenta' },
                { ' ', '' },
                { b_components.file_modified(' '), 'magenta' },
            }
        end
    end,
}
basic.git = {
    name = 'git',
    hl_colors = {
        green = { 'green', 'black' },
        red = { 'red', 'black' },
        blue = { 'blue', 'black' },
    },
    width = breakpoint_width,
    text = function(bufnr)
        if git_comps.is_git(bufnr) then
            return {
                { ' ', '' },
                { git_comps.diff_added({ format = ' %s', show_zero = true }), 'green' },
                { git_comps.diff_removed({ format = '  %s', show_zero = true }), 'red' },
                { git_comps.diff_changed({ format = ' 柳%s ', show_zero = true }), 'blue' },
            }
        end
        return ''
    end,
}
basic.venv = {
    name = 'venv',
    hl_colors = {
        blue = { 'blue', 'black' }
    },
    width = breakpoint_width,
    text = function()
        local handle = io.popen("echo \"$VIRTUAL_ENV\"")
        if handle == nil then
            return
        else
            local fullPath = handle:read("*a")
            handle:close()
            local venvName = string.gsub(fullPath, "/.*/", "")
            local output = string.gsub(venvName, "%c", "")
            if output ~= "" then
                return {
                    {"venv:" .. output .. " ", "blue"}
                }
            end
        end
    end
}

local quickfix = {
    filetypes = { 'qf', 'Trouble' },
    active = {
        { '🚦 Quickfix ', { 'white', 'black' } },
    },

    always_active = true,
    show_last_status = true,
}

local default = {
    filetypes = { 'default' },
    active = {
        basic.vi_mode,
        { ' ', hl_list.Black },
        basic.file,
        basic.lsp_diagnos,
        basic.divider,
        { git_comps.git_branch(), { 'magenta', 'black' }, breakpoint_width },
        basic.git,
        basic.venv,
        { ' ', hl_list.Black },
    },
    inactive = {
        { b_components.full_file_name, hl_list.Inactive },
        basic.file_name_inactive,
        basic.divider,
        { b_components.line_col, hl_list.Inactive },
        { b_components.progress, hl_list.Inactive },
    },
}
local toggleterm = {
    filetypes = { 'toggleterm' },
    active = {
        basic.vi_mode
    }
}

windline.setup({
    statuslines = {
        default,
        toggleterm,
        quickfix,
    },
})
-- require('wlfloatline').setup()
