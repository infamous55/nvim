local spec = {
    "stevearc/conform.nvim",
    name = "conform.nvim",
    event = { "BufReadPre" },
    cmd = { "ConformInfo" },
}

function spec:config()
    local conform = require("conform")
    conform.setup({
        formatters_by_ft = {
            typst = { "typstyle" },
            lua = { "stylua" },
            bash = { "shfmt" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            go = { "gofumpt", "goimports", "goimports-reviser", "golines" },
            html = { "prettier" },
            css = { "prettier" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = { timeout_ms = 500 },
    })
end

return spec
