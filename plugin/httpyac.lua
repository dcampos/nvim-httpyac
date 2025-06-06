
local abidibo_nvim_httpyac = vim.api.nvim_create_augroup(
    "NVIM_HTTPYAC",
    { clear = true }
)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "http",
    group = abidibo_nvim_httpyac,

    callback = function()
        vim.api.nvim_create_user_command('HttpYacAll', function(opts)
            require('nvim-httpyac').exec_httpyac({ args = { "-a" }, userArgs = opts.fargs, mods = opts.mods })
        end, { nargs = "*" })

        vim.api.nvim_create_user_command('HttpYac', function(opts)
            local curlineNumber = vim.api.nvim_win_get_cursor(0)[1]
            require('nvim-httpyac').exec_httpyac({ args = { "-l", curlineNumber }, userArgs = opts.fargs, mods = opts.mods })
        end, { nargs = "*" })

        -- Set current env for HttpYac
        vim.api.nvim_create_user_command('HttpYacSetEnv', function(opts)
            require('nvim-httpyac').set_env(opts.fargs[1])
        end, { nargs = 1, desc = "Set current env for HttpYac" })

    end,
})

-- Change ft to http for http extension
vim.filetype.add({ extension = { http = 'http' } })
