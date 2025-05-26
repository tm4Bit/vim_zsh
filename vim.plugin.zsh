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
