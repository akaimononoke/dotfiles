export LANG="en_GB.UTF-8"
export PROMPT="%n@%m %F{4}%~%F{sgr0} $ "

export PATH="$HOME/bin:$PATH"

# -------------------------------------------------- zsh completions --------------------------------------------------
FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
FPATH="$HOME/.zsh-completions:$FPATH"
autoload -Uz compinit
compinit -u

zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
# -------------------------------------------------- zsh completions --------------------------------------------------

# -------------------------------------------------- binutils --------------------------------------------------
export PATH="/usr/local/opt/binutils/bin:${PATH}"
export LDFLAGS="-L/usr/local/opt/binutils/lib"
export CPPFLAGS="-I/usr/local/opt/binutils/include"
# -------------------------------------------------- binutils --------------------------------------------------

# -------------------------------------------------- git --------------------------------------------------
alias ga='git_add'
alias gb='git branch'
alias gbc='git_branch_checkout'
alias gbd='git_branch_delete'
alias gbs='git_branch_select'
alias gc='git_commit'
alias gd='git diff'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gs='git status'

function git_add() {
	if [[ "$@" != "" ]]; then
		git add $@
	else
		git add --all
	fi
}

function git_branch_checkout() {
	local B=($(git_branch_select $1))
	if [ $#B -le 0 ]; then
		echo "No branch selected.\nCurrent branch: $(git_branch_current)"
		return 1
	fi

	if [[ "${B[*]}" =~ "origin" ]]; then
		git checkout --quiet -b "${B[(($#B))]}" "${B[(($#B - 1))]}/${B[(($#B))]}" >/dev/null
	else
		git checkout --quiet "${B[1]}"
	fi

	echo "Successfully checkouted.\nCurrent Branch: $(git_branch_current)"
}

function git_branch_select() {
	[ "$1" != "" ] && git fetch -p
	git branch $@ | sed -e 's/^[[:space:]]//' -e 's/^ //' -e '/\*/d' | peco | head -1 | sed 's/\// /g'
}

function git_branch_current() {
	git branch | sed -e '/\*/!d' -e 's/\* //'
}

function git_branch_delete() {
	local B=($(git_branch_select $1))
	[ $#B -gt 0 ] && git branch -d "${B[1]}"
}

function git_commit() {
	local message="$1"
	local commit_message="$(echo "$(date '+%Y-%m-%d %H:%M:%S') ${message}" | xargs echo -n)"
	git commit -m "${commit_message}"
}
# -------------------------------------------------- git --------------------------------------------------

# -------------------------------------------------- rust --------------------------------------------------
export CARGO_HOME="${HOME}/.cargo"
export PATH="${PATH}:${CARGO_HOME}/bin"
# -------------------------------------------------- rust --------------------------------------------------

# -------------------------------------------------- go --------------------------------------------------
export GOPATH="$(go env GOPATH)"
export GOBIN="$(go env GOBIN)"
export GOPKG="${GOPATH}/pkg"
export GOSRC="${GOPATH}/src"
export PATH="${PATH}:${GOBIN}"
# -------------------------------------------------- go --------------------------------------------------

# -------------------------------------------------- nodejs --------------------------------------------------
export PATH="${HOME}/.nodebrew/current/bin:${PATH}"
# -------------------------------------------------- nodejs --------------------------------------------------

# -------------------------------------------------- python --------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init --path)"
# -------------------------------------------------- python --------------------------------------------------

# -------------------------------------------------- java --------------------------------------------------
export PATH="${PATH}:/Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home/bin"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home
# -------------------------------------------------- java --------------------------------------------------

# -------------------------------------------------- postgresql --------------------------------------------------
export PGDATA=/usr/local/var/postgres
# -------------------------------------------------- postgresql --------------------------------------------------
