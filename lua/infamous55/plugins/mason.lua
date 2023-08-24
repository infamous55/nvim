local spec = {
    "williamboman/mason.nvim",
    name = "mason",
    lazy = true,
    priority = 10000,
    cmd = {
        "Mason",
        "MasonInstall",
        "MasonInstallAll",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
        "MasonUpdate",
    },
    build = ":MasonUpdate",
}

function spec:config()
    local mason = require("mason")
    mason.setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })
end

return spec
