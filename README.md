# Toggler.nvim

This plugin provides a flexible way to dynamically toggle commands in Neovim,
For example, on markdown files we might want to have a linter running on
`BufWritePost` such as `vale`, but running it every time might be too much.
`Toggler.nvim` provides an easy configurable way to register commands that can
be toggled on/off with a key binding.

## Installation

### Using vim-plug

```vim
Plug 'Piotr1215/toggler.nvim'
```

### Using packer.nvim

```lua
use 'Piotr1215/toggler.nvim'
```

## Usage

To toggle a command, configure your `init.lua` to set up the specific commands
you want to toggle along with their associated keybindings and optional events,
when the commands should be triggered. Here’s how to set it up:

> The plugin does not create commands, they must be available before toggling.

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

> The plugin does not come with any default commands or configuration, you must
> pass commands to toggle.

## Development

To load the plugin from a local environment for development, add this to your `init.lua`:

```lua
vim.opt.runtimepath:prepend("/path/to/your/toggler.nvim")
```

## Test

Tests can be run using the `vusted` framework:

```shell
vusted test
```

## CI

Continuous Integration setup includes generating Neovim help docs automatically
from the plugin's README.md file. This is done using the `vimdoc` tool. Ci also
runs tests.
