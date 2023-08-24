local spec = {
    "windwp/nvim-autopairs",
    name = "autopairs",
    event = "InsertEnter",
}

function spec:config()
    require("nvim-autopairs").setup()

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return spec
