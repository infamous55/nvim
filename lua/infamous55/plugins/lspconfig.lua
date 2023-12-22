local spec = {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "folke/neodev.nvim" },
}

function spec:init()
    vim.diagnostic.config({
        severity_sort = true,
        float = { source = true, border = "rounded" },
    })

    vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
end

function spec:config()
    require("neodev").setup()

    local lspconfig = require("lspconfig")

    lspconfig.util.on_setup = lspconfig.util.add_hook_after(
        lspconfig.util.on_setup,
        function(config)
            config.capabilities = vim.tbl_deep_extend(
                "force",
                config.capabilities,
                cmp.default_capabilities()
            )

            config.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            config.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = "rounded" }
            )
        end
    )

    vim.api.nvim_create_autocmd({ "LspAttach" }, {
        group = vim.api.nvim_create_augroup("config.plugins.lsp.attacher", {}),
        callback = function(args)
            local opts = { buffer = args.buf }

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, opts)
            vim.keymap.set(
                { "n", "v" },
                "<space>ca",
                vim.lsp.buf.code_action,
                opts
            )
            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
        end,
    })

    lspconfig.lua_ls.setup({})
    lspconfig.gopls.setup({})
    lspconfig.graphql.setup({})
    lspconfig.bashls.setup({})
    lspconfig.pyright.setup({})
    lspconfig.clangd.setup({})
    lspconfig.elixirls.setup({
        cmd = { "/home/infamous55/.local/share/nvim/mason/bin/elixir-ls" },
    })
end

return spec
