local spec = {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    event = { "BufReadPre", "BufNewFile" },
}

function spec:init()
    vim.diagnostic.config({
        severity_sort = true,
        float = { source = true, border = "rounded" },
    })

    vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end)
end

function spec:config()
    local lspconfig = require("lspconfig")

    local windows = require("lspconfig.ui.windows")
    windows.default_options.border = "rounded"
    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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
            vim.keymap.set("n", "<space>f", vim.lsp.buf.format, opts)
            vim.keymap.set(
                { "n", "v" },
                "<space>ca",
                vim.lsp.buf.code_action,
                opts
            )
        end,
    })

    lspconfig.lua_ls.setup({
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if
                vim.loop.fs_stat(path .. "/.luarc.json")
                or vim.loop.fs_stat(path .. "/.luarc.jsonc")
            then
                return
            end

            client.config.settings.Lua =
                vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        version = "LuaJIT",
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            "${3rd}/luv/library",
                        },
                    },
                })
        end,
        settings = {
            Lua = {},
        },
    })

    -- Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.html.setup({ capabilities = capabilities })

    lspconfig.marksman.setup({})
    lspconfig.typst_lsp.setup({})
    lspconfig.taplo.setup({})
    lspconfig.bashls.setup({})
    lspconfig.graphql.setup({})
    lspconfig.clangd.setup({})
    lspconfig.pyright.setup({})
    lspconfig.gopls.setup({})
    lspconfig.rust_analyzer.setup({})
    lspconfig.tsserver.setup({})
    lspconfig.elixirls.setup({
        cmd = {
            "/home/infamous55/.local/share/nvim/mason/packages/elixir-ls/language_server.sh",
        },
    })
    lspconfig.emmet_language_server.setup({
        filetypes = {
            "html",
            "css",
            "elixir",
            "eelixir",
            "heex",
            "typescriptreact",
        },
    })
    lspconfig.tailwindcss.setup({
        filetypes = { "html", "elixir", "eelixir", "heex", "typescriptreact" },
        init_options = {
            userLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
            },
        },
        settings = {
            tailwindCSS = {
                experimental = {
                    classRegex = {
                        "class[:]\\s*\"([^\"]*)\"",
                    },
                },
            },
        },
    })
end

return spec
