local spec = {
    "williamboman/mason-lspconfig.nvim",
    name = "mason-lspconfig",
    cmd = { "LspInstall", "LspUninstall" },
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
}

function spec:config()
    require("mason-lspconfig").setup()
end

return spec
