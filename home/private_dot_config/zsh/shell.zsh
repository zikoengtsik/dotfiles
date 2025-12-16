#!/usr/bin/env zsh

# ================================================================ #
# Functions
# ================================================================ #

# Check if the current system is Darwin
function on_darwin() { [ "$(uname)" = "Darwin" ]; }

# Check if a command exists
function is_command() { command -v "${1:?}" >/dev/null 2>&1; }

# ================================================================ #
# Package Manager
# ================================================================ #

# Homebrew
# ================================================================ #

if on_darwin; then
  if [ -f "/opt/homebrew/bin/brew" ]; then
    # For ARM macOS
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  if is_command brew; then
    # https://docs.brew.sh/Manpage#environment
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1

    # GNU Tools
    export PATH="${HOMEBREW_PREFIX}/opt/autoconf/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/bash/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/diffutils/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/file-formula/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/ed/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/flex/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/gawk/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/gnu-indent/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/gnu-which/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/gpatch/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/gzip/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/less/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/m4/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/make/libexec/gnubin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/man-db/libexec/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/wdiff/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/wget/bin:$PATH"
    export PATH="${HOMEBREW_PREFIX}/opt/zip/bin:$PATH"
  fi
fi

# ================================================================ #
# Terminal
# ================================================================ #

# Set terminal type
export TERM="xterm-256color"

# Language
export LANG="en_US.UTF-8"
export LC_ALL="${LANG}"

# Editor
export EDITOR="vim"
export VISUAL="${EDITOR}"

# Append XDG bin to PATH
export PATH="${XDG_BIN_HOME}:$PATH"

# Aliases
# ================================================================ #

# Make nvim as default vim
is_command nvim && { alias vim="nvim"; alias v="vim" }

# List the PATH separated by new lines
alias lpath='echo $PATH | tr ":" "\n"'

# Operate directory
alias md="mkdir -p"
alias rd="rmdir"

# List directory contents
alias ls="ls --color=auto -v"
alias l="ls -lah"
alias ll="ls -lh"
alias la="ls -lAh"

# Remove files and directories
alias rf="rm -rf"

# CLI Tools
# ================================================================ #

# less
less_opts=(
  # Quit if entire file fits on first screen.
  -FX
  # Do not complain when we are on a dumb terminal.
  --dumb
  # Ignore case in searches that do not contain uppercase.
  --ignore-case
  # Allow ANSI colour escapes, but no other escapes.
  --RAW-CONTROL-CHARS
  # Quiet the terminal bell. (when trying to scroll past the end of the buffer)
  --quiet
  # Enable mouse support.
  --mouse
)
export PAGER="less"
export LESS="${less_opts[@]}"
export LESSHISTFILE="${ZSH_STATE_DIR}/lesshist"
export LESSHISTSIZE=65535

# ================================================================ #
# Development Environment
# ================================================================ #

# Asdf
# ================================================================ #

export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export PATH="${ASDF_DATA_DIR}/shims:$PATH"

# Python
# ================================================================ #

# Pip
export PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"

# Virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Nodejs
# =============================================================== #

# Npm
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
