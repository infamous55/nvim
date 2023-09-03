local spec = {
    "kylechui/nvim-surround",
    version = "*",
    name = "surround",
    event = "VeryLazy",
}

function spec:config()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-surround").setup({})
end

return spec
