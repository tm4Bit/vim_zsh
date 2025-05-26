# README.md

```md
# Vim ZSH Plugin

A comprehensive and highly customizable vim plugin for zsh that brings advanced vim-like editing capabilities to your terminal with extensive features, visual feedback, and seamless integration.

## ✨ Features

### Core Functionality

- **Complete Vi mode keybindings** - Navigate and edit command line with full vim motions
- **Advanced cursor feedback** - Different cursor shapes for normal, insert, visual, and replace modes
- **Visual mode indicators** - Optional prompt indicators showing current vim mode
- **Complete text objects** - Support for quotes, brackets, words, and custom text objects
- **Full surround commands** - Add, change, and delete surrounding characters (vim-surround style)
- **Enhanced menu completion** - Vim keybindings in tab completion menus with advanced navigation
- **Register operations** - Basic vim-style register system for advanced text manipulation
- **History search integration** - Vim-like `/` and `?` for searching command history

### Advanced Features

- **Smart terminal detection** - Automatic tmux/screen compatibility with proper cursor sequences
- **Modular architecture** - Enable/disable features independently via environment variables
- **Plugin compatibility** - Exports mode state for integration with other zsh plugins
- **Performance optimized** - Minimal startup time with efficient key handling
- **Emacs hybrid mode** - Optional emacs-style shortcuts alongside vim bindings
- **Enhanced key handling** - Fixed arrow keys, home/end, backspace, and delete behavior
- **Replace mode support** - Full support for vim's replace mode with visual feedback
- **Debug mode** - Optional initialization feedback for troubleshooting

## 🚀 Installation

### Using ZSH Plugin Managers

**With [zap](https://github.com/zap-zsh/zap):**

\`\`\`bash
plug "tm4Bit/vim_zsh"
\`\`\`

**With [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh):**

\`\`\`bash
git clone https://github.com/tm4Bit/vim_zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vim_zsh
\`\`\`

Then add `vim_zsh` to your plugins array in `~/.zshrc`:

\`\`\`bash
plugins=(... vim_zsh)
\`\`\`

**With [zinit](https://github.com/zdharma-continuum/zinit):**

\`\`\`bash
zinit load "tm4Bit/vim_zsh"
\`\`\`

**With [antigen](https://github.com/zsh-users/antigen):**

\`\`\`bash
antigen bundle tm4Bit/vim_zsh
\`\`\`

### Manual Installation

\`\`\`bash
git clone https://github.com/tm4Bit/vim_zsh ~/.zsh/vim_zsh
echo "source ~/.zsh/vim_zsh/vim.plugin.zsh" >> ~/.zshrc
source ~/.zshrc
\`\`\`

## ⚙️ Configuration

All configuration is done through environment variables that should be set **before** loading the plugin.

### Custom Escape Key Binding

Map a key sequence to escape from insert mode:

\`\`\`bash
# Set escape sequence before loading plugin
export VI_MODE_ESC_INSERT="jk"
# Then load plugin
plug "tm4Bit/vim_zsh"
\`\`\`

Popular escape sequences:

- `jk` or `kj` - Fast typing sequences
- `jj` - Double character
- `;;` - Semicolon double-tap

### Cursor Shape Customization

#### Always Use the Same Cursor Shape

\`\`\`bash
# Always use block cursor
export VI_MODE_CURSOR_ALWAYS="\e[1 q"

# Always use beam cursor
export VI_MODE_CURSOR_ALWAYS="\e[5 q"

# Always use underline cursor
export VI_MODE_CURSOR_ALWAYS="\e[2 q"
\`\`\`

#### Different Cursors for Different Modes

\`\`\`bash
# Default configuration (block/beam/underline/block)
export VI_MODE_CURSOR_NORMAL="\e[1 q"   # Block for normal mode
export VI_MODE_CURSOR_INSERT="\e[5 q"   # Beam for insert mode
export VI_MODE_CURSOR_REPLACE="\e[2 q"  # Underline for replace mode
export VI_MODE_CURSOR_VISUAL="\e[1 q"   # Block for visual mode

# Alternative: Different cursor for each mode
export VI_MODE_CURSOR_NORMAL="\e[1 q"   # Block for normal
export VI_MODE_CURSOR_INSERT="\e[6 q"   # Blinking beam for insert
export VI_MODE_CURSOR_REPLACE="\e[3 q"  # Blinking underline for replace
export VI_MODE_CURSOR_VISUAL="\e[2 q"   # Solid underline for visual
\`\`\`

#### Available Cursor Shapes

| Code     | Shape             | Description           |
| -------- | ----------------- | --------------------- |
| `\e[1 q` | Block (solid)     | █ Traditional block   |
| `\e[2 q` | Underline (solid) | \_ Solid underline    |
| `\e[3 q` | Underline (blink) | \_ Blinking underline |
| `\e[4 q` | Line (solid)      | \| Thin vertical line |
| `\e[5 q` | Beam (solid)      | \| Solid beam/pipe    |
| `\e[6 q` | Beam (blinking)   | \| Blinking beam/pipe |

**Note:** `VI_MODE_CURSOR_ALWAYS` takes precedence over individual mode settings.

### Mode Indicators

Display current vim mode in your prompt:

\`\`\`bash
# Enable mode indicators
export VI_MODE_SHOW_INDICATOR="true"

# Customize indicator text (optional)
export VI_MODE_INDICATOR_NORMAL="[N]"   # Normal mode indicator
export VI_MODE_INDICATOR_INSERT="[I]"   # Insert mode indicator
export VI_MODE_INDICATOR_REPLACE="[R]"  # Replace mode indicator
export VI_MODE_INDICATOR_VISUAL="[V]"   # Visual mode indicator
\`\`\`

To use in your prompt, add `${VI_MODE_CURRENT_INDICATOR}` to your `PS1` or prompt theme:

\`\`\`bash
# Example prompt integration
PS1='${VI_MODE_CURRENT_INDICATOR}%n@%m:%~$ '
# or with colors
PS1='%F{blue}${VI_MODE_CURRENT_INDICATOR}%f %n@%m:%~$ '
\`\`\`

### Feature Toggles

Enable or disable major features:

\`\`\`bash
# Feature toggles (all default to "true")
export VI_MODE_ENABLE_SURROUND="true"       # Enable surround commands (cs, ds, ys)
export VI_MODE_ENABLE_TEXT_OBJECTS="true"   # Enable text objects (ci", ca(, etc.)
export VI_MODE_ENABLE_EMACS_BINDINGS="true" # Enable Ctrl+A, Ctrl+E, etc.
export VI_MODE_HISTORY_SEARCH="true"        # Enable /, ?, n, N for history search

# Disable features you don't want
export VI_MODE_ENABLE_SURROUND="false"      # Disable surround if not needed
\`\`\`

### Performance and Behavior

\`\`\`bash
# Key timeout configuration (in 10ms increments)
export VI_MODE_KEYTIMEOUT=25  # Default: 250ms
export VI_MODE_KEYTIMEOUT=10  # Faster response: 100ms
export VI_MODE_KEYTIMEOUT=50  # Slower response: 500ms

# Debug mode (shows initialization info)
export VI_MODE_DEBUG="true"
\`\`\`

## 🎯 Key Bindings Reference

### Basic Vi Motions

| Key  | Action                    | Mode   |
| ---- | ------------------------- | ------ |
| `h`  | Move left                 | Normal |
| `j`  | Move down                 | Normal |
| `k`  | Move up                   | Normal |
| `l`  | Move right                | Normal |
| `w`  | Next word                 | Normal |
| `b`  | Previous word             | Normal |
| `e`  | End of word               | Normal |
| `0`  | Beginning of line         | Normal |
| `^`  | First non-blank character | Normal |
| `$`  | End of line               | Normal |
| `gg` | First line in history     | Normal |
| `G`  | Last line in history      | Normal |

### Mode Switching

| Key    | Action                   | From Mode |
| ------ | ------------------------ | --------- |
| `i`    | Insert before cursor     | Normal    |
| `a`    | Insert after cursor      | Normal    |
| `I`    | Insert at line beginning | Normal    |
| `A`    | Insert at line end       | Normal    |
| `v`    | Enter visual mode        | Normal    |
| `R`    | Enter replace mode       | Normal    |
| `Esc`  | Return to normal mode    | Any       |
| Custom | Return to normal mode    | Insert    |

### Text Operations

| Key      | Action                  | Mode   |
| -------- | ----------------------- | ------ |
| `d`      | Delete (with motion)    | Normal |
| `dd`     | Delete entire line      | Normal |
| `D`      | Delete to end of line   | Normal |
| `c`      | Change (with motion)    | Normal |
| `cc`     | Change entire line      | Normal |
| `C`      | Change to end of line   | Normal |
| `y`      | Yank/copy (with motion) | Normal |
| `yy`     | Yank entire line        | Normal |
| `Y`      | Yank to end of line     | Normal |
| `p`      | Paste after cursor      | Normal |
| `P`      | Paste before cursor     | Normal |
| `u`      | Undo                    | Normal |
| `Ctrl+R` | Redo                    | Normal |
| `.`      | Repeat last change      | Normal |

### Text Objects

Text objects work with operations like `d`, `c`, `y`:

| Key     | Action                        |
| ------- | ----------------------------- |
| `ci"`   | Change inside double quotes   |
| `ca"`   | Change around double quotes   |
| `ci'`   | Change inside single quotes   |
| `ca'`   | Change around single quotes   |
| `ci(`   | Change inside parentheses     |
| `ca)`   | Change around parentheses     |
| `ci[`   | Change inside square brackets |
| `ca]`   | Change around square brackets |
| `ci{`   | Change inside curly braces    |
| `ca}`   | Change around curly braces    |
| `ci<`   | Change inside angle brackets  |
| `ca>`   | Change around angle brackets  |
| `ciw`   | Change inside word            |
| `caw`   | Change around word            |
| `ci`` ` | Change inside backticks       |
| `ca`` ` | Change around backticks       |

### Surround Commands

Inspired by vim-surround plugin:

| Command            | Action                       | Example                            |
| ------------------ | ---------------------------- | ---------------------------------- |
| `ys<motion><char>` | Add surrounding character    | `ysw"` → surround word with quotes |
| `cs<old><new>`     | Change surrounding character | `cs"'` → change " to '             |
| `ds<char>`         | Delete surrounding character | `ds(` → remove parentheses         |
| `S<char>`          | Surround selection (visual)  | Select text, `S"` → add quotes     |

**Examples:**

- `ysiw"` - Surround current word with double quotes
- `ysa"(` - Surround around quotes with parentheses
- `cs"'` - Change double quotes to single quotes
- `cs'<` - Change single quotes to angle brackets
- `ds(` - Delete surrounding parentheses
- `dst` - Delete surrounding HTML/XML tags

### History Search

| Key      | Action                         | Mode   |
| -------- | ------------------------------ | ------ |
| `/`      | Search backward in history     | Normal |
| `?`      | Search forward in history      | Normal |
| `n`      | Next search result             | Normal |
| `N`      | Previous search result         | Normal |
| `Ctrl+P` | Previous matching history line | Any    |
| `Ctrl+N` | Next matching history line     | Any    |

### Register Operations

| Key   | Action                  | Mode   |
| ----- | ----------------------- | ------ |
| `"`   | Access register         | Normal |
| `"ay` | Yank to register 'a'    | Normal |
| `"ap` | Paste from register 'a' | Normal |

### Menu Completion (Tab Completion)

When in tab completion menu:

| Key         | Action        |
| ----------- | ------------- |
| `Ctrl+h`    | Move left     |
| `Ctrl+l`    | Move right    |
| `Ctrl+j`    | Move down     |
| `Ctrl+k`    | Move up       |
| `Shift+Tab` | Move up       |
| `Enter`     | Accept item   |
| `Escape`    | Cancel menu   |
| `Tab`       | Accept & hold |

### Emacs-style Bindings (Insert Mode)

Available when `VI_MODE_ENABLE_EMACS_BINDINGS="true"`:

| Key      | Action               |
| -------- | -------------------- |
| `Ctrl+A` | Beginning of line    |
| `Ctrl+E` | End of line          |
| `Ctrl+B` | Move backward (left) |
| `Ctrl+F` | Move forward (right) |
| `Ctrl+K` | Kill to end of line  |
| `Ctrl+U` | Kill to beginning    |
| `Ctrl+W` | Kill previous word   |
| `Ctrl+Y` | Yank (paste)         |

## 🔧 Environment Variables Reference

### Core Configuration

| Variable             | Description                        | Default      | Example                |
| -------------------- | ---------------------------------- | ------------ | ---------------------- |
| `VI_MODE_ESC_INSERT` | Key sequence to escape insert mode | unset        | `"jk"`, `"jj"`, `";;"` |
| `VI_MODE_KEYTIMEOUT` | Key sequence timeout (10ms units)  | `25` (250ms) | `10`, `50`             |

### Cursor Configuration

| Variable                 | Description                   | Default          | Example    |
| ------------------------ | ----------------------------- | ---------------- | ---------- |
| `VI_MODE_CURSOR_ALWAYS`  | Cursor shape for all modes    | unset            | `"\e[1 q"` |
| `VI_MODE_CURSOR_NORMAL`  | Cursor shape for normal mode  | `\e[1 q` (block) | `"\e[2 q"` |
| `VI_MODE_CURSOR_INSERT`  | Cursor shape for insert mode  | `\e[5 q` (beam)  | `"\e[6 q"` |
| `VI_MODE_CURSOR_REPLACE` | Cursor shape for replace mode | `\e[2 q` (under) | `"\e[3 q"` |
| `VI_MODE_CURSOR_VISUAL`  | Cursor shape for visual mode  | `\e[1 q` (block) | `"\e[2 q"` |

### Mode Indicators

| Variable                    | Description                 | Default | Example     |
| --------------------------- | --------------------------- | ------- | ----------- |
| `VI_MODE_SHOW_INDICATOR`    | Enable mode indicators      | `false` | `"true"`    |
| `VI_MODE_INDICATOR_NORMAL`  | Normal mode indicator text  | `[N]`   | `"NORMAL"`  |
| `VI_MODE_INDICATOR_INSERT`  | Insert mode indicator text  | `[I]`   | `"INSERT"`  |
| `VI_MODE_INDICATOR_REPLACE` | Replace mode indicator text | `[R]`   | `"REPLACE"` |
| `VI_MODE_INDICATOR_VISUAL`  | Visual mode indicator text  | `[V]`   | `"VISUAL"`  |

### Feature Toggles

| Variable                        | Description                    | Default | Options          |
| ------------------------------- | ------------------------------ | ------- | ---------------- |
| `VI_MODE_ENABLE_SURROUND`       | Enable surround commands       | `true`  | `"true"/"false"` |
| `VI_MODE_ENABLE_TEXT_OBJECTS`   | Enable text objects            | `true`  | `"true"/"false"` |
| `VI_MODE_ENABLE_EMACS_BINDINGS` | Enable emacs-style bindings    | `true`  | `"true"/"false"` |
| `VI_MODE_HISTORY_SEARCH`        | Enable history search features | `true`  | `"true"/"false"` |

### Debug and Integration

| Variable        | Description                    | Default | Example  |
| --------------- | ------------------------------ | ------- | -------- |
| `VI_MODE_DEBUG` | Show initialization debug info | `false` | `"true"` |

## 📝 Configuration Examples

### Minimal Configuration

\`\`\`bash
# Just enable vim mode with custom escape
export VI_MODE_ESC_INSERT="jk"
plug "tm4Bit/vim_zsh"
\`\`\`

### Complete Customization

\`\`\`bash
# Custom escape sequence
export VI_MODE_ESC_INSERT="jk"

# Mode-specific cursors
export VI_MODE_CURSOR_NORMAL="\e[1 q"   # Block for normal
export VI_MODE_CURSOR_INSERT="\e[6 q"   # Blinking beam for insert
export VI_MODE_CURSOR_REPLACE="\e[3 q"  # Blinking underline for replace
export VI_MODE_CURSOR_VISUAL="\e[2 q"   # Solid underline for visual

# Enable mode indicators
export VI_MODE_SHOW_INDICATOR="true"
export VI_MODE_INDICATOR_NORMAL="[NORMAL]"
export VI_MODE_INDICATOR_INSERT="[INSERT]"

# Faster key timeout
export VI_MODE_KEYTIMEOUT=15

# Load the plugin
plug "tm4Bit/vim_zsh"

# Add mode indicator to prompt
PS1='%F{blue}${VI_MODE_CURRENT_INDICATOR}%f %n@%m:%~$ '
\`\`\`

### Feature-Selective Configuration

\`\`\`bash
# Enable only core vim features
export VI_MODE_ESC_INSERT="jj"
export VI_MODE_ENABLE_SURROUND="false"      # Disable surround
export VI_MODE_ENABLE_EMACS_BINDINGS="false" # Pure vim mode
export VI_MODE_HISTORY_SEARCH="true"        # Keep history search

# Unified cursor (no mode indication via cursor)
export VI_MODE_CURSOR_ALWAYS="\e[1 q"

# But show mode in prompt
export VI_MODE_SHOW_INDICATOR="true"

plug "tm4Bit/vim_zsh"
\`\`\`

### Terminal-Specific Configuration

\`\`\`bash
# Advanced terminal detection and configuration
if [[ "$TERM_PROGRAM" == "iTerm.app" ]] || [[ "$TERM" == "xterm-kitty" ]]; then
    # Full cursor support
    export VI_MODE_CURSOR_NORMAL="\e[1 q"   # Block
    export VI_MODE_CURSOR_INSERT="\e[5 q"   # Beam
    export VI_MODE_CURSOR_REPLACE="\e[2 q"  # Underline
    export VI_MODE_CURSOR_VISUAL="\e[1 q"   # Block
elif [[ -n "$TMUX" ]] || [[ "$TERM" == "screen"* ]]; then
    # tmux/screen - plugin handles wrapping automatically
    export VI_MODE_CURSOR_NORMAL="\e[1 q"
    export VI_MODE_CURSOR_INSERT="\e[5 q"
elif [[ "$TERM" == "linux" ]] || [[ "$TERM" == "console" ]]; then
    # Linux console - limited cursor support
    export VI_MODE_CURSOR_ALWAYS="\e[1 q"
    export VI_MODE_SHOW_INDICATOR="true"    # Use text indicators instead
else
    # Conservative fallback
    export VI_MODE_CURSOR_ALWAYS="\e[1 q"
fi

# Universal settings
export VI_MODE_ESC_INSERT="jk"
export VI_MODE_SHOW_INDICATOR="true"
export VI_MODE_DEBUG="true"  # Show what was detected

plug "tm4Bit/vim_zsh"
\`\`\`

### Integration with Prompt Themes

#### With Starship

\`\`\`toml
# In ~/.config/starship.toml
[custom.vi_mode]
command = "echo ${VI_MODE_CURRENT_INDICATOR}"
when = "[[ -n ${VI_MODE_CURRENT_INDICATOR} ]]"
format = "[$output]($style) "
style = "bold blue"
\`\`\`

#### With Oh My Zsh Themes

\`\`\`bash
# In your theme or ~/.zshrc
# Enable indicators
export VI_MODE_SHOW_INDICATOR="true"

# Modify your prompt to include the indicator
# Example for robbyrussell theme:
PROMPT='${VI_MODE_CURRENT_INDICATOR} ${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
\`\`\`

#### With Powerlevel10k

\`\`\`bash
# In ~/.p10k.zsh, add to POWERLEVEL9K_LEFT_PROMPT_ELEMENTS or POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS:
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # ... other elements ...
    vi_mode
    # ... other elements ...
)

# Configure the vi_mode segment
typeset -g POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND=0
typeset -g POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND=3
typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=0
typeset -g POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND=2
\`\`\`

## 🐛 Troubleshooting

### Cursor Not Changing

**Problem:** Cursor shape doesn't change between modes.

**Solutions:**

1. **Check terminal support:** Test cursor changes manually

   \`\`\`bash
   echo -ne '\e[5 q'  # Should show beam cursor
   echo -ne '\e[1 q'  # Should show block cursor
   \`\`\`

2. **Enable debug mode:**

   \`\`\`bash
   export VI_MODE_DEBUG="true"
   source ~/.zshrc
   \`\`\`

3. **tmux/screen users:** Plugin automatically handles wrapping, but verify tmux version:

   \`\`\`bash
   tmux -V  # Should be 2.1 or later for cursor support
   \`\`\`

4. **Try alternative cursor codes:**
   \`\`\`bash
   # For some terminals
   export VI_MODE_CURSOR_NORMAL="\e]50;CursorShape=0\x7"
   export VI_MODE_CURSOR_INSERT="\e]50;CursorShape=1\x7"
   \`\`\`

### Key Bindings Not Working

**Problem:** Vim keybindings don't respond or conflict with other plugins.

**Solutions:**

1. **Check plugin load order:** Load this plugin last or after conflicting plugins

   \`\`\`bash
   # In .zshrc - load vim_zsh after other plugins
   plugins=(git history-substring-search vim_zsh)
   \`\`\`

2. **Reset and test:**

   \`\`\`bash
   bindkey -d    # Reset all keybindings
   bindkey -v    # Re-enable vi mode
   source ~/.zshrc
   \`\`\`

3. **Check current bindings:**

   \`\`\`bash
   bindkey | grep vi-    # Check current vi bindings
   bindkey -M vicmd      # Check normal mode bindings
   bindkey -M viins      # Check insert mode bindings
   \`\`\`

4. **Disable conflicting features:**
   \`\`\`bash
   export VI_MODE_ENABLE_EMACS_BINDINGS="false"
   \`\`\`

### Mode Indicators Not Showing

**Problem:** Mode indicators don't appear in prompt.

**Solutions:**

1. **Verify configuration:**

   \`\`\`bash
   echo "Indicator enabled: $VI_MODE_SHOW_INDICATOR"
   echo "Current indicator: $VI_MODE_CURRENT_INDICATOR"
   \`\`\`

2. **Check prompt integration:**

   \`\`\`bash
   # Test if variable is available
   echo ${VI_MODE_CURRENT_INDICATOR}

   # Add to prompt manually
   PS1='${VI_MODE_CURRENT_INDICATOR} %n@%m:%~$ '
   \`\`\`

3. **Prompt theme conflicts:** Some themes override PS1 completely
   \`\`\`bash
   # Check if your theme supports custom variables
   # Or modify theme files directly
   \`\`\`

### Slow Key Response

**Problem:** Long delay when pressing keys or entering commands.

**Solutions:**

1. **Reduce timeout:**

   \`\`\`bash
   export VI_MODE_KEYTIMEOUT=10  # 100ms instead of 250ms
   \`\`\`

2. **Check for conflicting timeouts:**

   \`\`\`bash
   echo "Current timeout: $KEYTIMEOUT"
   \`\`\`

3. **Disable unused features:**
   \`\`\`bash
   export VI_MODE_ENABLE_SURROUND="false"
   export VI_MODE_ENABLE_TEXT_OBJECTS="false"
   \`\`\`

### Escape Sequence Issues

**Problem:** Custom escape sequence doesn't work reliably.

**Solutions:**

1. **Use shorter sequences:**

   \`\`\`bash
   export VI_MODE_ESC_INSERT="jk"  # Good
   # avoid: export VI_MODE_ESC_INSERT="jkl"  # Too long
   \`\`\`

2. **Avoid common character combinations:**

   \`\`\`bash
   # Good options:
   export VI_MODE_ESC_INSERT="jk"
   export VI_MODE_ESC_INSERT="jj"
   export VI_MODE_ESC_INSERT=";;"

   # Avoid sequences that appear in normal typing:
   # export VI_MODE_ESC_INSERT="th"  # Bad - appears in "the"
   \`\`\`

3. **Test the binding:**
   \`\`\`bash
   bindkey | grep "${VI_MODE_ESC_INSERT}"
   \`\`\`

### Integration Issues

**Problem:** Plugin doesn't work with other zsh plugins or frameworks.

**Solutions:**

1. **Load order matters:**

   \`\`\`bash
   # Load vim_zsh last
   plugins=(git history-substring-search syntax-highlighting vim_zsh)
   \`\`\`

2. **Check exported variables:**

   \`\`\`bash
   echo "Current mode: $VI_MODE_CURRENT"
   env | grep VI_MODE
   \`\`\`

3. **Framework-specific issues:**
   - **Oh My Zsh:** Ensure plugin is in correct directory and added to plugins array
   - **Zinit:** Use `zinit load` instead of `zinit light` for full functionality
   - **Antibody:** May need `antibody bundle` with full path

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

### Reporting Issues

1. **Include system information:**

   - Terminal emulator and version
   - tmux/screen usage
   - ZSH version (`zsh --version`)
   - Plugin manager used

2. **Provide configuration:**

   \`\`\`bash
   # Share your relevant environment variables
   env | grep VI_MODE
   \`\`\`

3. **Include reproduction steps** with expected vs actual behavior

### Feature Requests

- Describe your use case and desired functionality
- Check existing issues to avoid duplicates
- Consider if the feature fits vim philosophy

### Submitting Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Test your changes thoroughly
4. Update documentation if needed
5. Submit PR with clear description

### Development Setup

\`\`\`bash
git clone https://github.com/tm4Bit/vim_zsh.git
cd vim_zsh

# Test in isolated environment
zsh -c "source vim.plugin.zsh; zle -la | grep vi"

# Enable debug mode for development
export VI_MODE_DEBUG="true"
source vim.plugin.zsh
\`\`\`

### Testing Guidelines

\`\`\`bash
# Test basic functionality
bindkey -v  # Should enter vi mode
# Test escape sequence
# Test cursor changes
# Test mode indicators
# Test text objects: ci", ca(, etc.
# Test surround: ysiw", cs"', ds(
# Test history search: /, ?, n, N
\`\`\`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by vim editor and vim-surround plugin
- Built on zsh's powerful Zsh Line Editor (ZLE)
- Thanks to the zsh and vim communities for continuous inspiration
- Special thanks to contributors and users providing feedback

## 📚 Further Reading

- [ZSH Line Editor Documentation](http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html)
- [Vim Documentation](https://vimdoc.sourceforge.net/)
- [Advanced ZSH Configuration](https://github.com/ohmyzsh/ohmyzsh/wiki)

---

**Made with ❤️ for vim enthusiasts who live in the terminal**

_Bringing the power of vim to every command line interaction_

```

# vim.plugin.zsh

```zsh
#!/usr/bin/env zsh
# vim.plugin.zsh - Enhanced Vim mode for ZSH
# Repository: https://github.com/tm4Bit/vim_zsh

# =============================================================================
# CONFIGURATION AND DEFAULTS
# =============================================================================

# Enable vi mode
bindkey -v

# Set key timeout from environment variable or use default
export KEYTIMEOUT="${VI_MODE_KEYTIMEOUT:-25}"

# Cursor shape configuration via environment variables
# VI_MODE_CURSOR_NORMAL: cursor shape for normal/visual mode (default: block)
# VI_MODE_CURSOR_INSERT: cursor shape for insert mode (default: beam)
# VI_MODE_CURSOR_REPLACE: cursor shape for replace mode (default: underline)
# VI_MODE_CURSOR_VISUAL: cursor shape for visual mode (default: block)
# VI_MODE_CURSOR_ALWAYS: if set, use this shape for all modes
#
# Cursor shape codes:
# \e[1 q = block, \e[2 q = underline, \e[3 q = blinking underline
# \e[4 q = line, \e[5 q = beam, \e[6 q = blinking beam

# Set default cursor shapes
VI_MODE_CURSOR_NORMAL="${VI_MODE_CURSOR_NORMAL:-\e[1 q}"    # default: block
VI_MODE_CURSOR_INSERT="${VI_MODE_CURSOR_INSERT:-\e[5 q}"    # default: beam
VI_MODE_CURSOR_REPLACE="${VI_MODE_CURSOR_REPLACE:-\e[2 q}"  # default: underline
VI_MODE_CURSOR_VISUAL="${VI_MODE_CURSOR_VISUAL:-\e[1 q}"    # default: block

# If VI_MODE_CURSOR_ALWAYS is set, use it for all modes
if [[ -n "${VI_MODE_CURSOR_ALWAYS}" ]]; then
    VI_MODE_CURSOR_NORMAL="${VI_MODE_CURSOR_ALWAYS}"
    VI_MODE_CURSOR_INSERT="${VI_MODE_CURSOR_ALWAYS}"
    VI_MODE_CURSOR_REPLACE="${VI_MODE_CURSOR_ALWAYS}"
    VI_MODE_CURSOR_VISUAL="${VI_MODE_CURSOR_ALWAYS}"
fi

# Mode indicator configuration
VI_MODE_SHOW_INDICATOR="${VI_MODE_SHOW_INDICATOR:-false}"
VI_MODE_INDICATOR_NORMAL="${VI_MODE_INDICATOR_NORMAL:-[N]}"
VI_MODE_INDICATOR_INSERT="${VI_MODE_INDICATOR_INSERT:-[I]}"
VI_MODE_INDICATOR_REPLACE="${VI_MODE_INDICATOR_REPLACE:-[R]}"
VI_MODE_INDICATOR_VISUAL="${VI_MODE_INDICATOR_VISUAL:-[V]}"

# History search configuration
VI_MODE_HISTORY_SEARCH="${VI_MODE_HISTORY_SEARCH:-true}"

# Enhanced features toggles
VI_MODE_ENABLE_SURROUND="${VI_MODE_ENABLE_SURROUND:-true}"
VI_MODE_ENABLE_TEXT_OBJECTS="${VI_MODE_ENABLE_TEXT_OBJECTS:-true}"
VI_MODE_ENABLE_EMACS_BINDINGS="${VI_MODE_ENABLE_EMACS_BINDINGS:-true}"

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Function to safely echo cursor sequences (handles tmux/screen)
_vi_mode_set_cursor() {
    local cursor_code="$1"
		
    # Only set cursor if we're in an interactive terminal
    [[ -t 0 && -t 1 && -t 2 ]] || return
		
    if [[ -n "$TMUX" ]] || [[ "$TERM" == screen* ]]; then
        # tmux/screen escape sequence wrapping
        print -n "\ePtmux;\e${cursor_code}\e\\"
    else
        print -n "$cursor_code"
    fi
}

# Function to update mode indicator in prompt
_vi_mode_update_indicator() {
    local mode="$1"
    if [[ "$VI_MODE_SHOW_INDICATOR" == "true" ]]; then
        case "$mode" in
            normal) VI_MODE_CURRENT_INDICATOR="$VI_MODE_INDICATOR_NORMAL" ;;
            insert) VI_MODE_CURRENT_INDICATOR="$VI_MODE_INDICATOR_INSERT" ;;
            replace) VI_MODE_CURRENT_INDICATOR="$VI_MODE_INDICATOR_REPLACE" ;;
            visual) VI_MODE_CURRENT_INDICATOR="$VI_MODE_INDICATOR_VISUAL" ;;
        esac
        zle reset-prompt 2>/dev/null
    fi
}

# =============================================================================
# CORE VI MODE FUNCTIONALITY
# =============================================================================

# Enhanced keymap selection function with mode indicators
function zle-keymap-select() {
    case $KEYMAP in
        vicmd)
            _vi_mode_set_cursor "$VI_MODE_CURSOR_NORMAL"
            _vi_mode_update_indicator "normal"
            ;;
        viins|main)
            _vi_mode_set_cursor "$VI_MODE_CURSOR_INSERT"
            _vi_mode_update_indicator "insert"
            ;;
        viopp)
            # Operator pending mode - use normal cursor
            _vi_mode_set_cursor "$VI_MODE_CURSOR_NORMAL"
            ;;
        visual)
            _vi_mode_set_cursor "$VI_MODE_CURSOR_VISUAL"
            _vi_mode_update_indicator "visual"
            ;;
        virrep)
            # Replace mode
            _vi_mode_set_cursor "$VI_MODE_CURSOR_REPLACE"
            _vi_mode_update_indicator "replace"
            ;;
    esac
}
zle -N zle-keymap-select

# Initialize vi insert mode and cursor
function zle-line-init() {
    zle -K viins
    _vi_mode_set_cursor "$VI_MODE_CURSOR_INSERT"
    _vi_mode_update_indicator "insert"
}
zle -N zle-line-init

# Reset cursor after command execution
function zle-line-finish() {
    _vi_mode_set_cursor "$VI_MODE_CURSOR_INSERT"
}
zle -N zle-line-finish

# Set cursor on startup and for each new prompt
_vi_mode_set_cursor "$VI_MODE_CURSOR_INSERT"
preexec() {
    _vi_mode_set_cursor "$VI_MODE_CURSOR_INSERT"
}

# =============================================================================
# BASIC VI KEYBINDINGS AND FIXES
# =============================================================================

# Fix backspace and delete behavior
bindkey -v '^?' backward-delete-char
bindkey -v '^H' backward-delete-char
bindkey -v '^[[3~' delete-char

# Fix arrow keys in vi mode
bindkey -v '^[[A' up-line-or-history
bindkey -v '^[[B' down-line-or-history
bindkey -v '^[[C' forward-char
bindkey -v '^[[D' backward-char

# Home and End keys
bindkey -v '^[[H' beginning-of-line
bindkey -v '^[[F' end-of-line
bindkey -v '^[[1~' beginning-of-line
bindkey -v '^[[4~' end-of-line

# =============================================================================
# EMACS-STYLE BINDINGS (OPTIONAL)
# =============================================================================

if [[ "$VI_MODE_ENABLE_EMACS_BINDINGS" == "true" ]]; then
    # Essential emacs bindings in insert mode
    bindkey -M viins '^A' beginning-of-line
    bindkey -M viins '^E' end-of-line
    bindkey -M viins '^B' backward-char
    bindkey -M viins '^F' forward-char
    bindkey -M viins '^K' kill-line
    bindkey -M viins '^U' backward-kill-line
    bindkey -M viins '^W' backward-kill-word
    bindkey -M viins '^Y' yank
fi

# =============================================================================
# ENHANCED HISTORY SEARCH
# =============================================================================

if [[ "$VI_MODE_HISTORY_SEARCH" == "true" ]]; then
    # History search in normal mode
    bindkey -M vicmd '/' history-incremental-search-backward
    bindkey -M vicmd '?' history-incremental-search-forward
    bindkey -M vicmd 'n' history-search-forward
    bindkey -M vicmd 'N' history-search-backward
		
    # Partial line history search
    autoload -Uz history-search-end
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end
		
    bindkey -M vicmd '^P' history-beginning-search-backward-end
    bindkey -M vicmd '^N' history-beginning-search-forward-end
    bindkey -M viins '^P' history-beginning-search-backward-end
    bindkey -M viins '^N' history-beginning-search-forward-end
fi

# =============================================================================
# MENU COMPLETION WITH VIM BINDINGS
# =============================================================================

if [[ -o menucomplete ]]; then
    # Vim keys in tab completion menu
    bindkey -M menuselect '^h' vi-backward-char
    bindkey -M menuselect '^k' vi-up-line-or-history
    bindkey -M menuselect '^l' vi-forward-char
    bindkey -M menuselect '^j' vi-down-line-or-history
    bindkey -M menuselect '^[[Z' vi-up-line-or-history
		
    # Additional useful completion bindings
    bindkey -M menuselect '^M' accept-line
    bindkey -M menuselect '^[' send-break
    bindkey -M menuselect '^I' accept-and-hold
fi

# =============================================================================
# TEXT OBJECTS (OPTIONAL)
# =============================================================================

if [[ "$VI_MODE_ENABLE_TEXT_OBJECTS" == "true" ]]; then
    # Load built-in text object functions
    autoload -Uz select-bracketed select-quoted
    zle -N select-quoted
    zle -N select-bracketed
		
    # Bind text objects for quotes and brackets
    for mode in viopp visual; do
        # Quote text objects: ', ", `
        for char in {a,i}{\',\",\`}; do
            bindkey -M "$mode" -- "$char" select-quoted
        done
				
        # Bracket text objects: (), [], {}, <>, plus b and B for () and {}
        for char in {a,i}${(s..)^:-'()[]{}<>bB'}; do
            bindkey -M "$mode" -- "$char" select-bracketed
        done
    done
		
    # Custom word text objects - create our own functions
    _vi_select_in_word() {
        # Save current word chars and use default word boundaries
        local WORDCHARS_SAVE="$WORDCHARS"
        WORDCHARS=""
				
        # Find word boundaries
        local pos=$CURSOR
        # Move to start of word
        while [[ $pos -gt 0 && "${BUFFER[pos]}" != [[:space:]] ]]; do
            ((pos--))
        done
        # Skip any leading whitespace
        while [[ $pos -lt ${#BUFFER} && "${BUFFER[pos+1]}" == [[:space:]] ]]; do
            ((pos++))
        done
        local word_start=$pos
				
        # Move to end of word
        pos=$CURSOR
        while [[ $pos -lt ${#BUFFER} && "${BUFFER[pos+1]}" != [[:space:]] ]]; do
            ((pos++))
        done
        local word_end=$pos
				
        # Restore WORDCHARS
        WORDCHARS="$WORDCHARS_SAVE"
				
        # Set the region
        CURSOR=$word_start
        MARK=$word_end
        if [[ $KEYMAP == "viopp" ]]; then
            # In operator pending mode, we need to set the selection differently
            CURSOR=$word_start
            zle set-mark-command
            CURSOR=$word_end
        fi
    }
		
    _vi_select_a_word() {
        # Save current word chars
        local WORDCHARS_SAVE="$WORDCHARS"
        WORDCHARS=""
				
        # Find word with surrounding whitespace
        local pos=$CURSOR
        # Move to start of word (including leading whitespace)
        while [[ $pos -gt 0 && "${BUFFER[pos]}" == [[:space:]] ]]; do
            ((pos--))
        done
        while [[ $pos -gt 0 && "${BUFFER[pos]}" != [[:space:]] ]]; do
            ((pos--))
        done
        # Include trailing whitespace if we're not at start
        if [[ $pos -gt 0 ]]; then
            ((pos++))
        fi
        local word_start=$pos
				
        # Move to end of word (including trailing whitespace)
        pos=$CURSOR
        while [[ $pos -lt ${#BUFFER} && "${BUFFER[pos+1]}" != [[:space:]] ]]; do
            ((pos++))
        done
        while [[ $pos -lt ${#BUFFER} && "${BUFFER[pos+1]}" == [[:space:]] ]]; do
            ((pos++))
        done
        local word_end=$pos
				
        # Restore WORDCHARS
        WORDCHARS="$WORDCHARS_SAVE"
				
        # Set the region
        CURSOR=$word_start
        MARK=$word_end
        if [[ $KEYMAP == "viopp" ]]; then
            # In operator pending mode
            CURSOR=$word_start
            zle set-mark-command
            CURSOR=$word_end
        fi
    }
		
    zle -N _vi_select_in_word
    zle -N _vi_select_a_word
    bindkey -M viopp 'iw' _vi_select_in_word
    bindkey -M viopp 'aw' _vi_select_a_word
    bindkey -M visual 'iw' _vi_select_in_word
    bindkey -M visual 'aw' _vi_select_a_word
fi

# =============================================================================
# SURROUND COMMANDS (OPTIONAL)
# =============================================================================

if [[ "$VI_MODE_ENABLE_SURROUND" == "true" ]]; then
    # Load built-in surround functionality
    autoload -Uz surround
    zle -N delete-surround surround
    zle -N add-surround surround
    zle -N change-surround surround
		
    # Bind surround commands
    bindkey -M vicmd 'cs' change-surround
    bindkey -M vicmd 'ds' delete-surround
    bindkey -M vicmd 'ys' add-surround
    bindkey -M visual 'S' add-surround
fi

# =============================================================================
# ADVANCED VI COMMANDS
# =============================================================================

# Enhanced undo/redo
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo

# Command repetition (.)
bindkey -M vicmd '.' vi-repeat-change

# Line manipulation
bindkey -M vicmd 'dd' kill-whole-line
bindkey -M vicmd 'D' kill-line
bindkey -M vicmd 'C' vi-change-eol
bindkey -M vicmd 'cc' vi-change-whole-line
bindkey -M vicmd 'yy' vi-yank-whole-line
bindkey -M vicmd 'Y' vi-yank-eol

# Enhanced movement
bindkey -M vicmd 'gg' beginning-of-buffer-or-history
bindkey -M vicmd 'G' end-of-buffer-or-history

# =============================================================================
# CUSTOM ESCAPE SEQUENCE
# =============================================================================

# Set up custom escape sequence if defined
if [[ -n "${VI_MODE_ESC_INSERT}" ]]; then
    bindkey -M viins "${VI_MODE_ESC_INSERT}" vi-cmd-mode
fi

# =============================================================================
# REGISTER OPERATIONS (EXPERIMENTAL)
# =============================================================================

# Simple register support (stores in global variables)
typeset -A VI_MODE_REGISTERS

# Function to store text in a register
vi-set-register() {
    local reg="$1"
    local text="$2"
    VI_MODE_REGISTERS["$reg"]="$text"
}

# Function to get text from a register
vi-get-register() {
    local reg="$1"
    echo "${VI_MODE_REGISTERS[$reg]:-}"
}

# Enhanced yank that can use registers
vi-yank-to-register() {
    local reg="${KEYS[1]}"
    if [[ -n "$reg" ]]; then
        vi-set-register "$reg" "$CUTBUFFER"
        zle vi-yank
    else
        zle vi-yank
    fi
}
zle -N vi-yank-to-register

# Enhanced paste from register
vi-paste-from-register() {
    local reg="${KEYS[1]}"
    if [[ -n "$reg" ]]; then
        local text="$(vi-get-register "$reg")"
        if [[ -n "$text" ]]; then
            CUTBUFFER="$text"
            zle vi-put-after
        fi
    else
        zle vi-put-after
    fi
}
zle -N vi-paste-from-register

# Bind register operations (quote followed by register name)
bindkey -M vicmd '"' vi-set-buffer

# =============================================================================
# PLUGIN COMPATIBILITY AND CLEANUP
# =============================================================================

# Export current mode for other plugins to use
export VI_MODE_CURRENT="insert"

# Update mode variable when keymap changes
_vi_mode_track_mode() {
    case $KEYMAP in
        vicmd) export VI_MODE_CURRENT="normal" ;;
        viins|main) export VI_MODE_CURRENT="insert" ;;
        visual) export VI_MODE_CURRENT="visual" ;;
        virrep) export VI_MODE_CURRENT="replace" ;;
        viopp) export VI_MODE_CURRENT="operator" ;;
    esac
}

# Add mode tracking to keymap selection
_original_zle_keymap_select="$functions[zle-keymap-select]"
zle-keymap-select() {
    eval "$_original_zle_keymap_select"
    _vi_mode_track_mode
}

# =============================================================================
# INITIALIZATION COMPLETE
# =============================================================================

# Initialize mode indicator if enabled
if [[ "$VI_MODE_SHOW_INDICATOR" == "true" ]]; then
    VI_MODE_CURRENT_INDICATOR="$VI_MODE_INDICATOR_INSERT"
fi

# Print initialization message (optional)
if [[ "${VI_MODE_DEBUG:-false}" == "true" ]]; then
    echo "✓ Vim ZSH plugin loaded successfully"
    echo "  • Custom escape: ${VI_MODE_ESC_INSERT:-none}"
    echo "  • Mode indicator: $VI_MODE_SHOW_INDICATOR"
    echo "  • Text objects: $VI_MODE_ENABLE_TEXT_OBJECTS"
    echo "  • Surround: $VI_MODE_ENABLE_SURROUND"
fi

```

