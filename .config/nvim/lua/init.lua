vim.cmd 'packadd paq-nvim'         -- Load package
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function
paq{'savq/paq-nvim', opt=true}     -- Let Paq manage itself

-- Plugin testing
paq 'kyazdani42/nvim-tree.lua'
paq 'mfussenegger/nvim-dap'

paq 'b3nj5m1n/kommentary'
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'
paq {'neoclide/coc.nvim', branch='release'}
paq 'glepnir/zephyr-nvim'
paq 'lervag/vimtex'
paq 'tpope/vim-repeat'
paq 'justinmk/vim-sneak'
paq 'ledger/vim-ledger'
paq 'kshenoy/vim-signature'
paq 'nvim-treesitter/nvim-treesitter'
paq 'szw/vim-maximizer'
paq 'akinsho/nvim-toggleterm.lua'
-- paq 'puremourning/vimspector'
paq 'Yggdroot/indentLine'
paq 'simnalamburt/vim-mundo'
paq 'mhinz/vim-signify'
paq 'tpope/vim-fugitive'
paq 'lambdalisue/suda.vim'
paq 'glepnir/galaxyline.nvim'
paq 'kyazdani42/nvim-web-devicons'

require"toggleterm".setup{
    open_mapping = [[ t]]
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  indent = {
    enable = true
  }
}

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
        return "venv:" .. output
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
        separator = ' '
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
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[2] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    separator = ' ',
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[3] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = '  ',
    highlight = {colors.green,colors.bg},
  }
}
gls.right[4] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = ' 柳',
    highlight= {colors.orange,colors.bg},
  }
}
gls.right[5] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '  ',
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
        condition = python_check,
        highlight = {colors.fg, colors.bg, "bold"}
    }
}

gls.right[9] = {
  FileSize = {
    provider = 'FileSize',
    condition = buffer_not_empty,
    separator = ' ',
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.right[10] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg}
    }
}
gls.right[11] = {
  FileEncode = {
    provider = 'FileEncode',
    separator = ' ',
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

gls.short_line_left[1] = {
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
        separator = ' '
  },
}
gls.short_line_left[2] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[3] = {
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
