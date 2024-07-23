local spec = {
    "akinsho/bufferline.nvim",
    name = "bufferline",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

function spec:config()
    local bufferline = require("bufferline")
    bufferline.setup({
        options = {
            offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        },
    })

    vim.keymap.set("n", "<S-h>", "<cmd>bp<cr>", {})
    vim.keymap.set("n", "<S-l>", "<cmd>bn<cr>", {})
    vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>", {})
end

return spec
