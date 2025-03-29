#!/usr/bin/env bash

# =============================================================== #
# Vfox
# =============================================================== #

export XDG_DATA_HOME="${HOME}/.local/share"
export ZSH_COMPLETIONS_HOME="${XDG_DATA_HOME}/zsh/completions"
mkdir -p "${ZSH_COMPLETIONS_HOME}"

# Install vfox
if [ ! -f "/usr/local/bin/vfox" ]; then
  curl -sSL https://raw.githubusercontent.com/version-fox/vfox/main/install.sh | sudo bash
fi

# Add vfox completion
curl -fsL https://raw.githubusercontent.com/version-fox/vfox/refs/heads/main/completions/zsh_autocomplete -o "${ZSH_COMPLETIONS_HOME}/_vfox"

# Activate vfox
eval "$(vfox activate bash)"

# Upgrade vfox to the latest version
vfox upgrade

# Update all installed plugins
vfox update --all

# Golang
# =============================================================== #

GOLANG_VERSION=1.24.0
vfox add golang
vfox install "golang@${GOLANG_VERSION}"
vfox use -g "golang@${GOLANG_VERSION}"

# Python
# =============================================================== #

PYTHON_VERSION=3.12.8
vfox add python
vfox install "python@${PYTHON_VERSION}"
vfox use -g "python@${PYTHON_VERSION}"

# Upgrade pip to the latest version
pip install -q --upgrade pip

# Install packages
pip install -q -r /dev/stdin <<EOF
asciinema==2.4.0
ipython==9.0.2
poetry==2.1.1
tldr==3.3.0
EOF

# pip: pip completion --zsh
curl -fsL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/pip/_pip -o "${ZSH_COMPLETIONS_HOME}/_pip"

# poetry
# poetry completions zsh > "${ZSH_COMPLETIONS_HOME}/_poetry"
curl -fsL https://raw.githubusercontent.com/clarketm/zsh-completions/master/src/_poetry -o "${ZSH_COMPLETIONS_HOME}/_poetry"

# tldr
tldr --print-completion zsh > "${ZSH_COMPLETIONS_HOME}/_tldr"

# Nodejs
# =============================================================== #

NODEJS_VERSION=22.14.0
vfox add nodejs
vfox install "nodejs@${NODEJS_VERSION}"
vfox use -g "nodejs@${NODEJS_VERSION}"

# Upgrade npm to the latest version
npm install -s -g npm

# Pnpm
npm install -s -g pnpm@10.6.4
pnpm completion zsh > "${ZSH_COMPLETIONS_HOME}/_pnpm"
