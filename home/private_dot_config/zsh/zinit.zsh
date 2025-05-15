#!/usr/bin/env zsh

# ================================================================ #
# Zinit
# ================================================================ #

declare -A ZINIT
export ZINIT[ZCOMPDUMP_PATH]="${XDG_CACHE_HOME}/zinit/zcompdump"

# Installation
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
[ ! -d "${ZINIT_HOME}" ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d "${ZINIT_HOME}/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
source "${ZINIT_HOME}/zinit.zsh"

# Prompt & Theme
# ================================================================ #

# starship
zinit ice lucid as'command' from'gh-r' bpick'starship*.tar.gz' \
  atinit'
    export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/config.toml"
    export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"
  ' atclone'./starship completions zsh > _starship' atpull'%atclone' \
  pick'starship' atload'eval "$(starship init zsh)"'
zinit light starship/starship

# LS_COLORS
zinit ice lucid atclone'dircolors -b LS_COLORS > clrs.zsh' \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS

# direnv
zinit ice lucid as'command' from'gh-r' mv'direnv* -> direnv' atclone'
    curl -fsL https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_direnv -o ./_direnv
    ./direnv hook zsh > zhook.zsh
  ' atpull'%atclone' pick'direnv' src'zhook.zsh'
zinit light direnv/direnv

# Snippets
# ================================================================ #

# OMZ libs & plugins
zinit wait lucid for \
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
  atinit'GLOBALIAS_FILTER_VALUES=(
    grep ls pip vim
  )' \
    OMZP::globalias

# history
zinit wait lucid for \
  atinit'HIST_STAMPS=yyyy-mm-dd' \
    OMZL::history.zsh \
    OMZP::history

# git
zinit wait lucid for \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::gitignore

# sh-z
zinit ice wait lucid atinit'
    ZSHZ_DATA=${ZSH_STATE_HOME}/z
    ZSHZ_TILDE=1
  '
zinit light agkozak/zsh-z

# fast-syntax-highlighting
zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload'!_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# zsh-autopair
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# go
zinit wait lucid for \
    OMZP::golang \
    OMZP::golang/_golang

# python
zinit wait lucid for \
    OMZP::pip \
    OMZP::python

# Commands: Chezmoi
# ================================================================ #

# --- chezmoi --- #

zinit ice wait lucid as'command' from'gh-r' bpick'chezmoi*.tar.gz' \
  atclone'./chezmoi completion zsh > _chezmoi' atpull'%atclone' pick'chezmoi'
zinit light twpayne/chezmoi

# Commands: Secrets Management
# ================================================================ #

# --- sops --- #

zinit ice wait lucid nocompletions as'command' from'gh-r' bpick'sops*' mv'sops* -> sops' pick'sops'
zinit light getsops/sops

# --- age --- #

zinit ice wait lucid nocompletions as'command' from'gh-r' bpick'age*.tar.gz' pick'age/age*'
zinit light FiloSottile/age

# Commands: Development
# ================================================================ #

# --- yq --- #

zinit ice wait lucid as'command' from'gh-r' bpick'yq*.tar.gz' mv'yq_* -> yq' \
  atclone'./yq completion zsh > _yq' atpull'%atclone' pick'yq'
zinit light mikefarah/yq

# --- ripgrep --- #

zinit ice wait lucid as'command' from'gh-r' bpick'ripgrep*.tar.gz' mv'ripgrep* -> ripgrep' \
  atinit'export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/ripgreprc"' pick'ripgrep/rg'
zinit light BurntSushi/ripgrep

# --- git-delta --- #

zinit ice wait lucid as'command' from'gh-r' bpick'delta*.tar.gz' mv'delta* -> delta' \
  atclone'./delta/delta --generate-completion zsh > _delta' atpull'%atclone' \
  atinit'export DELTA_PAGER="${PAGER}"' pick'delta/delta'
zinit light dandavison/delta

# --- go-task --- #

zinit ice wait lucid as'command' from'gh-r' bpick'task*.tar.gz' pick'task'
zinit light go-task/task

# --- lefthook --- #

zinit ice wait lucid as'command' from'gh-r' bpick'lefthook*.gz' mv'lefthook* -> lefthook' \
  atclone'./lefthook completion zsh > _lefthook' atpull'%atclone' pick'lefthook'
zinit light evilmartians/lefthook

# --- uv --- #

zinit ice wait lucid as'command' from'gh-r' bpick'uv*.tar.gz' mv'uv* -> uv' \
  atclone'
    ./uv/uv generate-shell-completion zsh > ./uv/_uv
    ./uv/uvx --generate-shell-completion zsh > ./uv/_uvx
  ' atpull'%atclone' pick'uv/uv*'
zinit light astral-sh/uv

# --- k8s --- #

zinit ice wait lucid as'command' id-as'k8s-kubectl' atclone'
    curl -fsLS https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/$(uname | tr "[:upper:]" "[:lower:]")/$(uname -m)/kubectl -o ./kubectl
    chmod +x ./kubectl; ./kubectl completion zsh > _kubectl
  ' atpull'%atclone'
zinit light zdharma-continuum/null

zinit ice wait lucid as'command' from'gh-r' bpick'k9s*.tar.gz' \
  atclone'./k9s completion zsh > _k9s' atpull'%atclone' pick'k9s'
zinit light derailed/k9s

# Other Commands
# ================================================================ #

# --- zsh-completions --- #

zinit ice wait lucid as'command' id-as'zsh-completions' atclone'
    # docker
    has docker && docker completion zsh > "${ZSH_COMPLETIONS_HOME}/_docker"

    # Install completions from ${ZSH_COMPLETIONS_HOME}
    zinit creinstall -q ${ZSH_COMPLETIONS_HOME}
  ' atpull'%atclone' run-atpull
zinit light zdharma-continuum/null
