local spec = {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    build = ":TSUpdateSync",
    cmd = { "TSUpdateSync" },
    event = { "BufReadPre", "BufNewFile" },
}

function spec:config()
    local treesitter = require("nvim-treesitter.configs")
    ---@diagnostic disable-next-line: missing-fields
    treesitter.setup({
        ensure_installed = "all",
        sync_install = false,
        highlight = { enable = true, disable = { "latex" } },
        indent = { enable = true },
    })
end

return spec
