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

    local hover = vim.lsp.buf.hover
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.buf.hover = function()
        return hover({
            border = "rounded",
            max_height = math.floor(vim.o.lines * 0.5),
            max_width = math.floor(vim.o.columns * 0.4),
        })
    end

    local signature_help = vim.lsp.buf.signature_help
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.buf.signature_help = function()
        return signature_help({
            border = "rounded",
            max_height = math.floor(vim.o.lines * 0.5),
            max_width = math.floor(vim.o.columns * 0.4),
        })
    end

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

    lspconfig.html.setup({})
    lspconfig.marksman.setup({})
    lspconfig.tinymist.setup({})
    lspconfig.taplo.setup({})
    lspconfig.bashls.setup({})
    lspconfig.graphql.setup({})
    lspconfig.clangd.setup({})
    lspconfig.gopls.setup({})
    lspconfig.rust_analyzer.setup({})

    lspconfig.hls.setup({
        filetypes = { "haskell", "lhaskell", "cabal" },
    })

    lspconfig.denols.setup({
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    })
    lspconfig.ts_ls.setup({
        root_dir = lspconfig.util.root_pattern("package.json"),
        single_file_support = false,
    })

    lspconfig.ruff.setup({})
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup(
            "lsp_attach_disable_ruff_hover",
            { clear = true }
        ),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client == nil then
                return
            end
            if client.name == "ruff" then
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
            end
        end,
        desc = "LSP: Disable hover capability from Ruff",
    })
    lspconfig.pyright.setup({
        settings = {
            pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
            },
            python = {
                analysis = {
                    -- Ignore all files for analysis to exclusively use Ruff for linting
                    ignore = { "*" },
                },
            },
        },
    })

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
