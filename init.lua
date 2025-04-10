require("akif")

-- Detect .h files as c hedar files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.h"},
    callback = function()
        vim.bo.filetype = "c"
    end,
})

-- Enable tag-based navigation
vim.o.tags = './tags;,tags'

