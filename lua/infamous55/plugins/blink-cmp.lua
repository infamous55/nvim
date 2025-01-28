local spec = {
    "saghen/blink.cmp",
    version = "*",
    name = "blink.cmp",
    event = { "InsertEnter" },
    dependencies = {
        { "L3MON4D3/LuaSnip", version = "v2.*" },
        "rafamadriz/friendly-snippets",
    },
}

function spec:config()
    require("luasnip.loaders.from_vscode").lazy_load()

    local luasnip = require("luasnip")
    vim.keymap.set({ "i", "s" }, "<C-J>", function()
        luasnip.jump(-1)
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-L>", function()
        luasnip.jump(1)
    end, { silent = true })

    local blink_cmp = require("blink.cmp")
    blink_cmp.setup({
        keymap = {
            preset = "enter",
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        },
        completion = {
            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind" },
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                window = { border = "rounded" },
            },
            ghost_text = { enabled = true },
        },
        signature = { enabled = true, window = { border = "rounded" } },
        snippets = { preset = "luasnip" },
        sources = {
            cmdline = { enabled = false },
            default = { "lsp", "path", "snippets", "buffer" },
        },
    })
end

return spec
