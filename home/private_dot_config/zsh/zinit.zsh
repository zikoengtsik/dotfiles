#!/usr/bin/env zsh

# ================================================================ #
# Zinit
# ================================================================ #

# Initial Zinit's hash definition
declare -A ZINIT
export ZINIT[ZCOMPDUMP_PATH]="${ZSH_STATE_DIR}/zcompdump"

# Installation
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
[ ! -d ${ZINIT_HOME} ] && mkdir -p "$(dirname ${ZINIT_HOME})"
[ ! -d ${ZINIT_HOME}/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
source "${ZINIT_HOME}/zinit.zsh"

# Append Zinit to the MANPATH
export MANPATH=":${ZINIT[MAN_DIR]}"

# Appearance
# ================================================================ #

# Starship
zinit ice lucid as'command' from'gh-r' bpick'starship*.tar.gz' \
  atinit'
    export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/config.toml"
    export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"
  ' atclone'./starship completions zsh > ./_starship' atpull'%atclone' \
  pick'starship' atload'eval "$(starship init zsh)"'
zinit light starship/starship

# fast-syntax-highlighting
zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload'!_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Oh My Zsh!
# ================================================================ #

# OMZ libs & plugins
zinit wait lucid for \
    OMZL::async_prompt.zsh \
    OMZL::functions.zsh \
    OMZL::grep.zsh \
  atinit'
    zstyle ":omz:plugins:alias-finder" autoload yes
    zstyle ":omz:plugins:alias-finder" longer yes
    zstyle ":omz:plugins:alias-finder" exact yes
    zstyle ":omz:plugins:alias-finder" cheaper yes
  ' \
    OMZP::alias-finder \
    OMZP::extract \
    OMZP::colored-man-pages \
    OMZP::command-not-found \
  atinit'GLOBALIAS_FILTER_VALUES=(grep ls pip)' \
    OMZP::globalias

# history
zinit wait lucid for \
  atinit'
    HIST_STAMPS=yyyy-mm-dd
  ' \
    OMZL::history.zsh \
    OMZP::history

# git
zinit wait lucid for \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::gitignore

# golang
zinit wait lucid for \
    OMZP::golang \
  as'completion' \
    OMZP::golang/_golang

# python
zinit wait lucid for \
    OMZP::pip \
  as'completion' \
    OMZP::pip/_pip \
    OMZP::python

# Commands
# ================================================================ #

# --- chezmoi --- #

zinit ice wait lucid as'command' from'gh-r' bpick'chezmoi*.tar.gz' \
  atclone'./chezmoi completion zsh > ./_chezmoi' atpull'%atclone' pick'chezmoi'
zinit light twpayne/chezmoi

# --- tealdeer --- #

zinit ice wait lucid as'command' from'gh-r' bpick'tealdeer*' mv'tealdeer* -> tldr' \
  atclone'
    curl -fsL https://raw.githubusercontent.com/tealdeer-rs/tealdeer/refs/heads/main/completion/zsh_tealdeer -o ./_tldr
  ' atpull'%atclone' pick'tldr'
zinit light tealdeer-rs/tealdeer

# Commands - Secrets Management
# ================================================================ #

# --- sops --- #

zinit ice wait lucid as'command' from'gh-r' bpick'sops*' mv'sops* -> sops' atclone'
    curl -fsL https://raw.githubusercontent.com/zchee/zsh-completions/refs/heads/main/src/go/_sops -o ./_sops
  ' atpull'%atclone' pick'sops'
zinit light getsops/sops

# --- age --- #

zinit ice wait lucid as'command' from'gh-r' bpick'age*.tar.gz' atclone'
    curl -fsL https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_age -o ./_age
  ' atpull'%atclone' pick'age/age*'
zinit light FiloSottile/age

# Commands - Development Tools
# ================================================================ #

# --- direnv --- #

zinit ice lucid as'command' from'gh-r' mv'direnv* -> direnv' atclone'
    curl -fsL https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_direnv -o ./_direnv
    ./direnv hook zsh > zhook.zsh
  ' atpull'%atclone' pick'direnv' src'zhook.zsh'
zinit light direnv/direnv

# --- go-task --- #

zinit ice wait lucid as'command' from'gh-r' bpick'task*.tar.gz' pick'task'
zinit light go-task/task

# --- k8s --- #

# kubectl
zinit ice wait lucid as'command' id-as'k8s-kubectl' atclone'
    uname_arch() {
      local arch=$(uname -m)
      case $arch in
        x86_64) arch="amd64" ;;
        x86) arch="386" ;;
        i686) arch="386" ;;
        i386) arch="386" ;;
        aarch64) arch="arm64" ;;
        armv5*) arch="arm" ;;
        armv6*) arch="arm" ;;
        armv7*) arch="arm" ;;
      esac
      echo ${arch}
    }
    curl -fsLS https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/$(uname | tr "[:upper:]" "[:lower:]")/$(uname_arch)/kubectl -o ./kubectl
    chmod +x ./kubectl; ./kubectl completion zsh > _kubectl
  ' atpull'%atclone'
zinit light zdharma-continuum/null

# --- uv --- #

zinit ice wait lucid as'command' from'gh-r' bpick'uv*.tar.gz' mv'uv* -> uv' \
  atclone'
    ./uv/uv generate-shell-completion zsh > ./_uv
    ./uv/uvx --generate-shell-completion zsh > ./_uvx
  ' atpull'%atclone' pick'uv/uv*'
zinit light astral-sh/uv

# Commands - Misc
# ================================================================ #

# --- zsh-completions --- #

zinit ice wait lucid as'command' id-as'zsh-completions' atclone'
    # asdf
    is_command asdf && asdf completion zsh > ./_asdf
    # docker
    is_command docker && docker completion zsh > ./_docker
    # pre-commit
    is_command pre-commit && curl -fsL https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_pre-commit -o ./_pre-commit
  ' atpull'%atclone' run-atpull
zinit light zdharma-continuum/null
