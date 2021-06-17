export LANG="en_GB.UTF-8"
export PROMPT="%n@%m %F{4}%~%F{sgr0} $ "

# zsh-completions
if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
	autoload -Uz compinit
	compinit -u
fi

# Rust
export CARGO_HOME="${HOME}/.cargo"
export PATH="${PATH}:${CARGO_HOME}/bin"

# Go
export GOPATH="$(go env GOPATH)"
export GOBIN="$(go env GOBIN)"
export GOPKG="${GOPATH}/pkg"
export GOSRC="${GOPATH}/src"
export PATH="${PATH}:${GOBIN}"

# Python
export PYENV_ROOT="/usr/local/var/pyenv"
export PATH="${PATH}:${PYENV_ROOT}/bin"
if type pyenv &>/dev/null; then
	eval "$(pyenv init -)"
fi

# Php
[[ -e "${HOME}/.phpbrew/bashrc" ]] && source "${HOME}/.phpbrew/bashrc"

# Java
export PATH=$PATH:/Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home

# Git
export GITHUB="${GOSRC}/github.com"
export KZMSHRT="${GITHUB}/kzmshrt"
export PATEDEKAZU="${GITHUB}/patedekazu"
export DOTFILES="${PATEDEKAZU}/dotfiles"
export PATH="${PATH}:${DOTFILES}/bin"

# copy my shells to ~/bin
for f in $(ls ${DOTFILES}/profile.d/*); do . $f; done

# postgresql
export PGDATA=/usr/local/var/postgres
