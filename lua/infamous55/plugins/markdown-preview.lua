local spec = {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
}

function spec:build()
    vim.fn["mkdp#util#install"]()
end

return spec
