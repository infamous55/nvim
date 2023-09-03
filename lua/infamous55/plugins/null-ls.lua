local spec = {
    "jose-elias-alvarez/null-ls.nvim",
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
            null.builtins.formatting.stylua,
            null.builtins.formatting.gofumpt,
            null.builtins.formatting.goimports,
            null.builtins.formatting.goimports_reviser,
            null.builtins.formatting.golines,
            null.builtins.formatting.prettier,
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
