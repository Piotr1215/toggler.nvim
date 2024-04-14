vim.api.nvim_create_user_command('ToggleCommand', function(opts)
    local args = {}
    -- Parse options passed as key-value pairs
    for i = 1, #opts.fargs, 2 do
        args[opts.fargs[i]] = opts.fargs[i + 1]
    end
    require('toggler').toggle_command(args)
end, { nargs = '*' })
