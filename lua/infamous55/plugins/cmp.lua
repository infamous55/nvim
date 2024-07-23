local spec = {
    "hrsh7th/nvim-cmp",
    name = "cmp",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-omni",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "onsails/lspkind.nvim",
    },
}

function spec:config()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    local lspkind = require("lspkind")

    vim.keymap.set({ "i", "s" }, "<C-J>", function()
        luasnip.jump(-1)
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-L>", function()
        luasnip.jump(1)
    end, { silent = true })

    cmp.setup({
        snippet = {
            expand = function(opts)
                luasnip.lsp_expand(opts.body)
            end,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "omni" },
            { name = "buffer" },
            { name = "path" },
        },
        formatting = {
            expandable_indicator = true,
            fields = { "abbr", "kind" },
            format = lspkind.cmp_format({
                mode = "symbol",
                menu = {
                    omni = "",
                },
            }),
        },
        mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),

            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),

            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        experimental = { ghost_text = true },
    })
end

return spec
