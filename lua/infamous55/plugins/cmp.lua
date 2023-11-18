local spec = {
    "hrsh7th/nvim-cmp",
    name = "cmp",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-omni",
        -- "kdheepak/cmp-latex-symbols",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
    },
}

function spec:config()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    ---@diagnostic disable-next-line: missing-fields
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
            -- {
            --     name = "latex_symbols",
            --     filetype = { "tex", "latex" },
            --     option = { cache = true },
            -- },
        },
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
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
