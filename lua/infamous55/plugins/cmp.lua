local spec = {
    "hrsh7th/nvim-cmp",
    name = "cmp",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
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
            { name = "buffer" },
            {
                name = "path",
            },
        },
        ---@diagnostic disable-next-line: missing-fields
        formatting = { format = lspkind.cmp_format({ mode = "symbol" }) },
        mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),

            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),

            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),

            ["<Tab>"] = cmp.mapping(function(fallback)
                local col = vim.fn.col(".") - 1
                if cmp.visible() then
                    cmp.select_next_item()
                elseif
                    col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
                then
                    fallback()
                else
                    cmp.complete()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        experimental = { ghost_text = true },
    })
end

return spec
