local B = require("nvim-httpyac.buffer")
local M = {}

M.exec_httpyac = function(opts)
    opts = opts or {}

    local args = opts.args or { "-a" }
    local userArgs = opts.userArgs or {}

    local file_path = vim.fn.expand('%:p')

    -- open split buffer
    B.open_buffer(opts.mods)

    local allArgs = { 'httpyac', file_path}
    vim.list_extend(allArgs, args)
    vim.list_extend(allArgs, userArgs)

    if M.current_env then
        vim.list_extend(allArgs, { "-e", M.current_env })
    end

    -- execute httpyac asynchronously
    vim.system(allArgs, { text = true },
        vim.schedule_wrap(function(obj)
            B.log(obj.stdout)
        end)
    )
end

function M.set_env(env)
    M.current_env = env
end

function M.setup()
end

return M
