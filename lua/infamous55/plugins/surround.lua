local spec = {
    "kylechui/nvim-surround",
    version = "*",
    name = "surround",
    event = "VeryLazy",
}

function spec:config()
    require("nvim-surround").setup({})
end

return spec
