# README.md

```md
# Vim zsh Plugin

A comprehensive vim plugin for zsh that brings vim-like editing capabilities to your terminal with extensive customization options.

## Features

- **Vi mode keybindings** - Navigate and edit command line with vim motions
- **Visual cursor feedback** - Different cursor shapes for different modes
- **Text objects** - Support for quotes, brackets, and other text objects
- **Surround commands** - Add, change, and delete surrounding characters
- **Menu completion** - Vim keybindings in tab completion menus
- **Emacs-style shortcuts** - Convenient `Ctrl+A` and `Ctrl+E` bindings
- **Highly customizable** - Environment variables for all major behaviors

## Installation

### Using a ZSH plugin manager

**With [zap](https://github.com/zap-zsh/zap):**

\`\`\`bash
plug "tm4Bit/vim"
\`\`\`

**With [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh):**

\`\`\`bash
git clone https://github.com/tm4Bit/vim ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vim
# Add 'vim' to your plugins array in ~/.zshrc
\`\`\`

### Manual installation

\`\`\`bash
git clone https://github.com/tm4Bit/vim ~/.zsh/vim
echo "source ~/.zsh/vim/vim.plugin.zsh" >> ~/.zshrc
\`\`\`

## Configuration

### Custom Escape Key Binding

Map a key sequence to escape from insert mode (common vim practice):

\`\`\`bash
export VI_MODE_ESC_INSERT="jk" && plug "tm4Bit/vim"
\`\`\`

This allows you to press `jk` to escape to normal mode instead of reaching for the `Esc` key.

### Cursor Shape Customization

Control cursor appearance with environment variables:

#### Always use the same cursor shape

\`\`\`bash
# Always use block cursor
export VI_MODE_CURSOR_ALWAYS="\e[1 q"

# Always use beam cursor
export VI_MODE_CURSOR_ALWAYS="\e[5 q"

# Always use underline cursor
export VI_MODE_CURSOR_ALWAYS="\e[2 q"
\`\`\`

#### Different cursors for different modes

\`\`\`bash
# Block cursor in normal mode, beam in insert mode (default)
export VI_MODE_CURSOR_NORMAL="\e[1 q"
export VI_MODE_CURSOR_INSERT="\e[5 q"

# Underline in normal mode, blinking beam in insert mode
export VI_MODE_CURSOR_NORMAL="\e[2 q"
export VI_MODE_CURSOR_INSERT="\e[6 q"
\`\`\`

#### Available cursor shapes:

- `\e[1 q` - Block (solid)
- `\e[2 q` - Underline (solid)
- `\e[3 q` - Underline (blinking)
- `\e[4 q` - Line (solid)
- `\e[5 q` - Beam/pipe (solid)
- `\e[6 q` - Beam/pipe (blinking)

**Note:** `VI_MODE_CURSOR_ALWAYS` takes precedence over individual mode settings.

## Key Bindings

### Basic Vi Motions

- `h`, `j`, `k`, `l` - Move left, down, up, right
- `w`, `b`, `e` - Word motions
- `0`, `^`, `$` - Line motions
- `i`, `a`, `I`, `A` - Insert modes
- `v` - Visual mode
- `d`, `c`, `y` - Delete, change, yank operations

### Text Objects

- `ci"`, `ca"` - Change inside/around double quotes
- `ci'`, `ca'` - Change inside/around single quotes
- `ci(`, `ca(` - Change inside/around parentheses
- `ci[`, `ca[` - Change inside/around square brackets
- `ci{`, `ca{` - Change inside/around curly braces
- `ci<`, `ca<` - Change inside/around angle brackets

### Surround Commands

- `ys<motion><char>` - Add surrounding character
- `cs<old><new>` - Change surrounding character
- `ds<char>` - Delete surrounding character
- `S<char>` - Surround selection (in visual mode)

**Examples:**

- `ysiw"` - Surround word with double quotes
- `cs"'` - Change double quotes to single quotes
- `ds(` - Delete surrounding parentheses

### Menu Completion

When in tab completion menu:

- `Ctrl+h`, `Ctrl+l` - Move left/right
- `Ctrl+j`, `Ctrl+k` - Move down/up
- `Shift+Tab` - Move up

### Emacs-style Bindings (Insert Mode)

- `Ctrl+A` - Beginning of line
- `Ctrl+E` - End of line

## Environment Variables Reference

| Variable                | Description                         | Default          |
| ----------------------- | ----------------------------------- | ---------------- |
| `VI_MODE_ESC_INSERT`    | Key sequence to escape insert mode  | unset            |
| `VI_MODE_CURSOR_ALWAYS` | Cursor shape for all modes          | unset            |
| `VI_MODE_CURSOR_NORMAL` | Cursor shape for normal/visual mode | `\e[1 q` (block) |
| `VI_MODE_CURSOR_INSERT` | Cursor shape for insert mode        | `\e[5 q` (beam)  |

## Examples

### Complete configuration example

\`\`\`bash
# Custom escape sequence
export VI_MODE_ESC_INSERT="jk"

# Always use block cursor
export VI_MODE_CURSOR_ALWAYS="\e[1 q"

# Load the plugin
plug "tm4Bit/vim"
\`\`\`

### Mode-specific cursor configuration

\`\`\`bash
# Different cursors for each mode
export VI_MODE_CURSOR_NORMAL="\e[2 q"  # underline for normal
export VI_MODE_CURSOR_INSERT="\e[6 q"  # blinking beam for insert

# Custom escape sequence
export VI_MODE_ESC_INSERT="jj"

plug "tm4Bit/vim"
\`\`\`

## Troubleshooting

### Cursor not changing

- Ensure your terminal supports cursor shape changes
- Try different cursor codes if your terminal uses non-standard sequences
- Some terminals may require different escape sequences

### Key bindings not working

- Make sure the plugin loads after other plugins that might conflict
- Check if other plugins override the same key bindings
- Verify that `bindkey -v` is not being called elsewhere in your configuration

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License.

```

# vim.plugin.zsh

```zsh
#!/bin/sh
bindkey -v
export KEYTIMEOUT=25

# Cursor shape configuration via environment variables
# VI_MODE_CURSOR_NORMAL: cursor shape for normal/visual mode (default: block)
# VI_MODE_CURSOR_INSERT: cursor shape for insert mode (default: beam)
# VI_MODE_CURSOR_ALWAYS: if set, use this shape for all modes
#
# Cursor shape codes:
# \e[1 q = block, \e[2 q = underline, \e[3 q = blinking underline
# \e[4 q = line, \e[5 q = beam, \e[6 q = blinking beam

# Set default cursor shapes
VI_MODE_CURSOR_NORMAL="${VI_MODE_CURSOR_NORMAL:-\e[1 q}"  # default: block
VI_MODE_CURSOR_INSERT="${VI_MODE_CURSOR_INSERT:-\e[5 q}"  # default: beam

# If VI_MODE_CURSOR_ALWAYS is set, use it for both modes
if [[ -n "${VI_MODE_CURSOR_ALWAYS}" ]]; then
    VI_MODE_CURSOR_NORMAL="${VI_MODE_CURSOR_ALWAYS}"
    VI_MODE_CURSOR_INSERT="${VI_MODE_CURSOR_ALWAYS}"
fi

if [[ -o menucomplete ]]; then 
  # Use vim keys in tab complete menu:
  bindkey -M menuselect '^h' vi-backward-char
  bindkey -M menuselect '^k' vi-up-line-or-history
  bindkey -M menuselect '^l' vi-forward-char
  bindkey -M menuselect '^j' vi-down-line-or-history
  bindkey -M menuselect '^[[Z' vi-up-line-or-history
fi

bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne "${VI_MODE_CURSOR_NORMAL}";;
        viins|main) echo -ne "${VI_MODE_CURSOR_INSERT}";;
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "${VI_MODE_CURSOR_INSERT}"
}
zle -N zle-line-init
echo -ne "${VI_MODE_CURSOR_INSERT}" # Use configured cursor shape on startup
preexec() { echo -ne "${VI_MODE_CURSOR_INSERT}" ;} # Use configured cursor shape for each new prompt

# emacs like keybindings
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line

# Add text objects for quotes and brackets.
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for m in viopp visual; do
  for c in {a,i}{\',\",\`}; do
      bindkey -M $m -- $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
      bindkey -M $m -- $c select-bracketed
  done
done

# Add surround like commands.
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround
# escape back into normal mode
if [[ -n "${VI_MODE_ESC_INSERT}" ]] then
    bindkey -M viins "${VI_MODE_ESC_INSERT}" vi-cmd-mode
fi

```

