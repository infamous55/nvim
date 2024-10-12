local spec = {
    "nvimtools/none-ls.nvim",
    name = "null-ls",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
}

function spec:config()
    local null = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null.setup({
        bordered = "rounded",
        sources = {
            null.builtins.formatting.typstfmt,
            null.builtins.formatting.stylua,
            null.builtins.formatting.prettier,
            null.builtins.formatting.shfmt,
            null.builtins.formatting.clang_format,
            null.builtins.formatting.gofumpt,
            null.builtins.formatting.goimports,
            null.builtins.formatting.goimports_reviser,
            null.builtins.formatting.golines,
        },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end
        end,
    })
end

return spec
