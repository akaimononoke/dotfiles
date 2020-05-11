alias zp='. ${ZPROFILE} && . ${ZSHRC}'
alias ll='ls -la'
alias confsh='zsh ${YAKAMON_SHCONF}/setup.sh && exec ${SHELL} -l'

export LANG="en_GB.UTF-8"
export PROMPT="%n@%m %F{4}%~%F{sgr0} $ "
export ZPROFILE="${HOME}/.zprofile"
export ZSHRC="${HOME}/.zshrc"

# zsh-completions
if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
	autoload -U compinit
	compinit -u
fi

# go
export GOPATH="$(go env GOPATH)"
export GOBIN="$(go env GOBIN)"
export GOPKG="${GOPATH}/pkg"
export GOSRC="${GOPATH}/src"
export PATH="${PATH}:${GOBIN}"

# pyenv
export PYENV_ROOT="/usr/local/var/pyenv"
export PATH="${PATH}:${PYENV_ROOT}/bin"
if type pyenv &>/dev/null; then
	eval "$(pyenv init -)"
fi

# rust
export CARGO_HOME="${HOME}/.cargo"
export PATH="${PATH}:${CARGO_HOME}/bin"

# git
export GITHUB="${GOSRC}/github.com"
export YAKAMON="${GITHUB}/yakamon"
export YAKAMON_ALGO="${YAKAMON}/algo"
export YAKAMON_SHCONF="${YAKAMON}/shconf"
export PATH="${PATH}:${YAKAMON_SHCONF}/bin"

# load profiles
for FILE in $(ls ${YAKAMON_SHCONF}/conf/*); do
	. ${FILE}
done

# update
if type update_onload &>/dev/null; then
	update_onload
fi
