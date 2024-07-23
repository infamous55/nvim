local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")
lazy.setup("infamous55.plugins", {
    defaults = { lazy = true },
    concurrency = 4,
    install = { missing = true, colorscheme = { "github_dark_colorblind" } },
    diff = { cmd = "git" },
    change_detection = { enabled = true, notify = true },
    performance = {
        cache = { enabled = true },
        reset_packpath = true,
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
