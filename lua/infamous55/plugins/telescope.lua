local spec = {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    cmd = { "Telescope" },
    keys = { "<leader>ff", "<leader>lg" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
}

function spec:config()
    local telescope = require("telescope")
    telescope.setup({ pickers = { colorscheme = { enable_preview = true } } })

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
    vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
end

return spec
