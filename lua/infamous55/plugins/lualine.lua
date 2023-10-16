local spec = {
    "nvim-lualine/lualine.nvim",
    name = "lualine",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

function spec:config()
    require("lualine").setup({
        options = {
            theme = "github_dark_colorblind",
        },
    })
end

return spec
