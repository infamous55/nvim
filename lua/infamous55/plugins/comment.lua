local spec = {
    "numToStr/Comment.nvim",
    name = "comment",
    lazy = false,
}

function spec:config()
    require("Comment").setup()
end

return spec
