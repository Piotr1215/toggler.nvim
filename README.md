# Toggler.nvim

This plugin provides a flexible way to dynamically toggle commands in Neovim, such as linters or formatters, based on user-configurable keybindings and events. It's especially useful for developers who need to quickly enable or disable tools without leaving their editor environment.

## Installation

### Using vim-plug

```vim
Plug 'yourusername/toggler.nvim'
```

### Using packer.nvim

```lua
use 'yourusername/toggler.nvim'
```

## Usage

To toggle a tool, configure your `init.lua` to set up the specific commands you want to toggle along with their associated keybindings and optional events. Here’s how to set it up:

### Basic Configuration

```lua
require('toggler').setup({
    {
        name = "Vale",
        cmd = "Vale",
        key = "<leader>vl",
        pattern = "*.md",
        event = "BufWritePost"  -- This is optional; default is 'BufWritePost'
    },
    {
        name = "ESLint",
        cmd = "Eslint --fix",
        key = "<leader>el",
        pattern = "*.js",
        event = "TextChanged,TextChangedI"  -- Trigger on text change
    }
})
```

This configuration will:
- Toggle Vale on Markdown files with `<leader>vl` on buffer write post.
- Toggle ESLint on JavaScript files with `<leader>el` on text changes.

### Commands

To manually toggle a command without a keybinding, use:

```vim
:ToggleCommand name Vale cmd "Vale" pattern "*.md"
```

### Dependencies

Neovim 0.5 or higher is required due to the use of advanced Lua features.

## Configuration

The plugin is highly configurable. Below is an example to customize the toggler:

```lua
require('toggler').setup({
    {
        name = "MyLinter",
        cmd = "mylinter --fix",
        key = "<leader>ml",
        pattern = "*.py",
        event = "BufEnter"  -- Trigger on entering the buffer
    }
})
```

## Development

To load the plugin from a local environment for development, add this to your `init.lua`:

```lua
vim.opt.runtimepath:prepend("/path/to/your/toggler.nvim")
```

## Test

Tests can be run using the `vusted` framework:

```shell
vusted --nvim /path/to/neovim test/
```

## CI

Continuous Integration setup includes generating Neovim help docs automatically from the
