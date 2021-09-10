-- cmp config
local cmp = require'cmp'
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n', true)
            elseif has_words_before() and vim.fn['vsnip#available']() == 1 then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '', true)
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function()
            if vim.fn.pumvisible() == 1 then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n', true)
            elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), '', true)
            end
        end, { 'i', 's' }),
        -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        -- ['<CR>'] = cmp.mapping.confirm({
        --     behavior = cmp.ConfirmBehavior.Replace,
        --     select = true,
        -- })
    },
    sources = {
      { name = 'buffer' },
      { name = 'latex_symbols' },
      { name = 'vsnip' },
      { name = 'treesitter' },
      { name = 'path'},
      { name = 'calc'},
      { name = 'nvim_lsp'},
      { name = 'nvim_lua'}
    }
})
--
-- nvim-autopairs config
_G.MUtils= {}
local npairs = require('nvim-autopairs')
npairs.setup({
    check_ts = true,
    enable_check_bracket_line = true,
    ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
})
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))

require("nvim-autopairs.completion.cmp").setup({
    map_cr = true,
    map_complete = true,
    auto_select = true
})

-- dap config
local dap = require 'dap'
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
    continue = {'.continue', '.c', 'c'},
    next_ = {'.next', '.n', 'n', 'next'},
    back = {'.back', '.b', 'b'},
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

-- galaxyline config
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
