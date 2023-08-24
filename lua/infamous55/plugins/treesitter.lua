local spec = {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    build = ":TSUpdateSync",
    cmd = { "TSUpdateSync" },
    event = { "BufReadPre", "BufNewFile" },
}

function spec:config()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
        ensure_installed = "all",
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    })
end

return spec
