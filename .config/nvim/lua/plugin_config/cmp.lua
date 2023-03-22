-- cmp config
local cmp = require('cmp')
local luasnip = require('luasnip')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" })
    },
    sources = {
      { name = 'nvim_lsp'},
      { name = 'nvim_lua'},
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'treesitter' },
      { name = 'rg' },
      { name = 'omni' },
      { name = 'path'},
      { name = 'orgmode' },
      { name = 'nvim_lsp_signature_help'}

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
