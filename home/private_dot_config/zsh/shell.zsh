#!/usr/bin/env zsh

# =========================================================== #
# Functions
# =========================================================== #

function has() { command -v "${1:?}" >/dev/null 2>&1; }

function on_darwin() { [ $(uname) = "Darwin" ]; }

# =========================================================== #
# Package Manager
# =========================================================== #

# Homebrew
# =========================================================== #

if on_darwin; then
  if [ -f "/opt/homebrew/bin/brew" ]; then
    # For ARM macOS
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  if has brew; then
    # https://docs.brew.sh/Manpage#environment
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1

    fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)

    # Coreutils
    export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
    # File-formula
    export PATH="${HOMEBREW_PREFIX}/opt/file-formula/bin:$PATH"
    # Gnu-tar
    export PATH="${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin:$PATH"
    # Gnu-sed
    export PATH="${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin:$PATH"
    # Less
    export PATH="${HOMEBREW_PREFIX}/opt/less/bin:$PATH"
  fi
fi

# =========================================================== #
# General
# =========================================================== #

# Append XDG bin to PATH
export PATH="${XDG_BIN_HOME}:$PATH"

# Append ZSH completions to FPATH
export FPATH="${ZSH_COMPLETIONS_HOME}:$FPATH"

# Set terminal type
export TERM="xterm-256color"

# Language
export LANG="en_US.UTF-8"

# Editor
export EDITOR="vim"
export VISUAL="${EDITOR}"

# Commands
# =========================================================== #

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
)
export PAGER="less"
export LESS="${less_opts[@]}"
export LESSHISTFILE="${ZSH_STATE_HOME}/lesshist"
export LESSHISTSIZE=65535

# gawk
has gawk && alias awk="gawk"

# Aliases
# =========================================================== #

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
alias rmf="rm -rf"

# =========================================================== #
# ASDF
# =========================================================== #

export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_DATA_DIR="${ASDF_DIR}"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"

[ ! -d ${ASDF_DIR}/.git ] && git clone https://github.com/asdf-vm/asdf.git "${ASDF_DIR}"
source "${ASDF_DIR}/asdf.sh"

export FPATH="${ASDF_DIR}/completions:$FPATH"

# Python
# =========================================================== #

# virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# pip
export PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"

# poetry
export POETRY_CACHE_DIR="${XDG_CACHE_HOME}/poetry"
export POETRY_DATA_DIR="${XDG_DATA_HOME}/poetry"
