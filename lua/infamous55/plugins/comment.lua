local spec = {
    "numToStr/Comment.nvim",
    name = "comment",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
}

function spec:config()
    require("Comment").setup()
end

return spec
