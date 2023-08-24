local spec = {
    "lewis6991/gitsigns.nvim",
    name = "gitsigns",
    lazy = true,
    event = { "BufRead" },
}

function spec:config()
    local gitsigns = require("gitsigns")
    gitsigns.setup({})
end

return spec
