alias ga='git_add'              # Git Add
alias gb='git branch'           # Git Branch
alias gbc='git_branch_checkout' # Git Branch Checkout
alias gbd='git_branch_delete'   # Git Branch Delete
alias gbs='git_branch_select'   # Git Branch Select
alias gcd='git_commit_date'     # Git Commit with Date
alias gd='git diff'             # Git Diff
alias gf='git fetch'            # Git Fetch
alias gl='git pull'             # Git pulL
alias gp='git push'             # Git Push
alias gs='git status'           # Git Status

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
		echo "No branch selected.\nCurrent branch: $(color red)$(git_branch_current)$(color)"
		return 1
	fi

	if [[ "${B[*]}" =~ "origin" ]]; then
		git checkout --quiet -b "${B[(($#B))]}" "${B[(($#B - 1))]}/${B[(($#B))]}" >/dev/null
	else
		git checkout --quiet "${B[1]}"
	fi

	echo "Successfully checkouted.\nCurrent Branch: $(color red)$(git_branch_current)$(color)"
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

function git_commit_date() {
	if [ "$1" != "" ]; then
		git commit -m "$(now) $1"
	else
		git commit -m "$(now)"
	fi
}

function git_checkout_files() {
	local B=($(git_branch_select))
	local CHECKOUT_LIST=($(cat $1))
	if [ $#B -gt 0 ]; then
		for CHECKOUT_PATH in ${CHECKOUT_LIST[*]}; do
			git checkout ${B} ${CHECKOUT_PATH}
		done
	fi
}
