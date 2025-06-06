require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
  },
  
  ensure_installed = 'all', -- Or run :TSUpdate org
  ignore_install = {'org'},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },
}
require('orgmode').setup{
  org_agenda_file = '~/Dropbox/org/*',
  org_default_notes_file = '~/Dropbox/org/school.org',
}

