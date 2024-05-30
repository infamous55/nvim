local spec = {
    "NvChad/nvim-colorizer.lua",
    name = "colorizer",
    lazy = true,
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" },
}

function spec:config()
    require("colorizer").setup({})
end

return spec
