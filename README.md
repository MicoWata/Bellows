# Bellows
<img src="screenshot.png" width="600" alt="Bellows plugin demo showing code folding">
A neovim plugin to fold your code like an accordionist.

Actually just a few expressive keymaps and a shining polish to improve neovim's rickety folding behavior.

## Features

- ⌨️  Intuitive keymaps for expressive fold controls
- 🎨 Elegant treesitter highlighted folds
- 💾 Automatic fold persistence between sessions

## Keymaps

Try them, many practical combos to discover !

| Keymap         | Description           | 
|----------------|-----------------------|
| `<Shift-End>`  | Move to next fold     |
| `<Shift-Home>` | Move to previous fold |
| `<Shift-Up>`   | Close all folds       |
| `<Shift-Left>` | Close all other folds |
| `<Shift-Right>` | Toggle fold           |
| `<Shift-Down>` | Toggle fold cascade   |

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "micowata/bellows",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}
```
## Requirements

- Neovim >= 0.8.0
- nvim-treesitter

## Commands

The plugin automatically handles fold persistence through these events:

- `BufWinLeave`: Automatically saves fold state
- `BufWinEnter`: Automatically restores fold state

## FAQ

**Q: Why aren't my folds persisting between sessions?**
A: Make sure you have `set viewoptions?` properly configured. The minimal required options are `folds,cursor`.

**Q: Can I change the default keymaps or the fold text ?**
A: I'm working on it :)

## License

MIT - See [LICENSE](./LICENSE) for more information.

## Acknowledgments

- The Neovim community for inspiration and support
- this reddit post : [reddit post](https://www.reddit.com/r/neovim/comments/16sqyjz/finally_we_can_have_highlighted_folds)
