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

