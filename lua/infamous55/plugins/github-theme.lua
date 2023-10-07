local spec = {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
}

function spec:config()
    -- vim.cmd("colorscheme github_dark_colorblind")
    vim.cmd("colorscheme github_dark_high_contrast")
end

return spec
