local M = {}
M.toggle_states = {}

function M.toggle_command(cfg)
  local key = cfg.name
  local event = cfg.event or 'BufWritePost' -- Default event
  if M.toggle_states[key] then
    print(key .. ' disabled')
    vim.api.nvim_clear_autocmds({ group = key .. 'Group' })
    M.toggle_states[key] = false
  else
    print(key .. ' enabled')
    vim.api.nvim_create_augroup(key .. 'Group', { clear = true })
    vim.api.nvim_create_autocmd(event, {
      group = key .. 'Group',
      pattern = cfg.pattern,
      command = cfg.cmd,
    })
    M.toggle_states[key] = true
  end
end

function M.setup(configs)
  for _, cfg in ipairs(configs) do
    local cmd = string.format(
      "<cmd>lua require('toggler').toggle_command({name = '%s', cmd = '%s', pattern = '%s', event = '%s'})<CR>",
      cfg.name,
      cfg.cmd,
      cfg.pattern,
      cfg.event or 'BufWritePost'
    )
    vim.api.nvim_set_keymap('n', cfg.key, cmd, { noremap = true, silent = true })
  end
end

return M
