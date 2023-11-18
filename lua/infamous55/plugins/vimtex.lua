local spec = {
    "lervag/vimtex",
    name = "vimtex",
    ft = { "tex", "plaintex" },
}

function spec:config()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_general_viewer = "zathura"
    vim.g.vimtex_quickfix_mode = 0

    vim.g.vimtex_compiler_latexmk = {
        out_dir = ".out",
        options = {
            "-shell-escape",
            "-verbose",
            "-file-line-error",
            "-interaction=nonstopmode",
            "-synctex=1",
        },
    }

    vim.g.vimtex_fold_enabled = 1
    vim.g.vimtex_format_enabled = 1
end

return spec
