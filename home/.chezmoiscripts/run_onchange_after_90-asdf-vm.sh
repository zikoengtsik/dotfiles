#!/usr/bin/env bash

# =============================================================== #
# Asdf
# =============================================================== #

# XDG Base Directory Environment Vars
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_DATA_HOME="${HOME}/.local/share"

# Asdf Environment Vars
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export PATH="${XDG_BIN_HOME}:${PATH}"
export PATH="${ASDF_DATA_DIR}/shims:$PATH"

# Make sure the directories exist.
mkdir -p "${XDG_BIN_HOME}" "${XDG_DATA_HOME}"

# Update all installed plugins
asdf plugin update --all

# Golang
# =============================================================== #

GOLANG_VERSION=1.25.5

asdf plugin add golang
asdf install golang "${GOLANG_VERSION}"
asdf set -u golang "${GOLANG_VERSION}"

# Python
# =============================================================== #

PYTHON_VERSION=3.12.12

asdf plugin add python
asdf install python "${PYTHON_VERSION}"
asdf set -u python "${PYTHON_VERSION}"

# Upgrade pip to the latest version
pip install -q --upgrade pip

# Install packages
pip install -q -r /dev/stdin <<EOF
pre-commit==4.5.0
EOF

# Nodejs
# =============================================================== #

NODEJS_VERSION=24.12.0

asdf plugin add nodejs
asdf install nodejs "${NODEJS_VERSION}"
asdf set -u nodejs "${NODEJS_VERSION}"

# Upgrade npm to the latest version
npm install -s -g npm
