local wk = require("which-key")

wk.register({
    s = "which_key_ignore",
    S = "which_key_ignore",
    ["]"] = "which_key_ignore",
    ["["] = "which_key_ignore",
    e = "Line diagnostics",
    u = "Undotree",
    ["|"] = "Vertical Split",
    ["-"] = "Horizontal Split",
    c = {
        name = "Code action",
        a = "Code action",
        s = "Clangd Switch Source Header",
        r = "Rename"
    },
    q = {
        name = "Quickfix",
        f = "Toggle",
        n = "Next quickfix",
        p = "Previous quickfix"
    },
    w = {
        name = "Window",
        h = "Focus left",
        l = "Focus right",
        j  = "Focus down",
        k = "Focus up"
    },
    d = {
        name = "Debugger",
        c = "Continue",
        j = "Step over",
        l = "Step",
        h = "Step out",
        b = "Breakpoint",
        B = "Conditional breakpoint",
        p = "Breakpoint log",
    },
    f = {
        name = "Telescope",
        f = "Files",
        g = "Grep",
        b = "Buffers",
        m = "Marks",
        q = "Quickfix",
        t = "Todo"
    },
    g = {
        name = "Git",
        c = "Commits",
        b = "Branches",
        s = "Status",
        d = "Diff"
    },
    t = {
        name = "Trouble",
        o = "Toggle",
        t = "Todo",
        w = "Workspace diagnostics",
        d = "Document diagnostics",
        q = "Quickfix",
        r = "Refresh"
    },
    h = {
        name = "Gitsigns",
        s = "Stage hunk",
        u = "Undo stage hunk",
        r = "Reset hunk",
        R = "Reset buffer",
        b = "Blame",
        p = "Preview hunk",
    },
}, { prefix = "<leader>" })

wk.register({
    d = "Previous diagnostic",
    h = "Previous hunk",
    q = "Previous quickfix"
}, { prefix = "[" })

wk.register({
    d = "Next diagnostic",
    h = "Next hunk",
    q = "Next quickfix"
}, { prefix = "]" })

wk.register({
    c = "Kommentary motion"
}, { prefix = "g" })
