local spec = {
    "jay-babu/mason-null-ls.nvim",
    name = "mason-null-ls",
    cmd = { "NullLsInstall", "NullLsUninstall" },
    dependencies = {
        "williamboman/mason.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    },
}

function spec:config()
    require("mason-null-ls").setup()
end

return spec
