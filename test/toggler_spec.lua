local toggler = require('toggler')

-- Helper function to simulate setting up buffers and commands
local function setup_buffer_and_command(command_cfg)
  vim.cmd('enew')                               -- Ensure a clean buffer
  vim.bo[0].filetype = 'markdown'               -- Set filetype
  vim.bo[0].buftype = 'nofile'                  -- Avoid issues with file types
  vim.cmd('file ' .. command_cfg.name .. '.md') -- Unique file name for each test

  toggler.setup({ command_cfg })                -- Setup command configuration
end

describe('Toggler Plugin', function()
  describe('toggle_command function', function()
    it('should toggle the command state correctly', function()
      local command_cfg = {
        name = "MockLinter",
        cmd = "echo 'Linting...'", -- Mock command for testing
        key = "<leader>ml",
        pattern = "*.md",
        event = "BufWritePost"
      }

      setup_buffer_and_command(command_cfg)

      -- Toggle the command twice to enable and disable
      toggler.toggle_command(command_cfg)
      assert.is_true(toggler.toggle_states["MockLinter"], "Command should be enabled")
      toggler.toggle_command(command_cfg)
      assert.is_false(toggler.toggle_states["MockLinter"], "Command should be disabled")
    end)
  end)

  describe('Toggler Plugin with Different Events', function()
    local test_cases = {
      { event = "BufRead",     name = "BufReadEvent" },
      { event = "BufEnter",    name = "BufEnterEvent" },
      { event = "TextChanged", name = "TextChangedEvent" }
    }

    for _, test_case in ipairs(test_cases) do
      it('should handle the ' .. test_case.event .. ' event correctly', function()
        local command_cfg = {
          name = test_case.name,
          cmd = "echo 'Event Testing...'",
          key = "<leader>e",
          pattern = "*.test",
          event = test_case.event
        }

        setup_buffer_and_command(command_cfg)

        -- Enable the command
        toggler.toggle_command(command_cfg)
        assert.is_true(toggler.toggle_states[test_case.name], "Command should be enabled")

        -- Properly simulate the event
        if test_case.event == "BufRead" then
          vim.cmd('edit!')                              -- Reload the buffer to simulate BufRead
        elseif test_case.event == "BufEnter" then
          vim.cmd('bunload!')                           -- Unload buffer
          vim.cmd('edit ' .. test_case.name .. '.test') -- Re-enter buffer
        elseif test_case.event == "TextChanged" then
          vim.cmd('normal! i ')                         -- Simulate text change
        end

        -- Verify the state remains correctly enabled
        assert.is_true(toggler.toggle_states[test_case.name], "Command should remain enabled after event")

        -- Disable for cleanup
        toggler.toggle_command(command_cfg)
        vim.cmd('bdelete!') -- Close the buffer without saving
      end)
    end
  end)
end)
