alias ua='update_all'

function update_all() {
	bar "=" 90 "Updating Homebrew..."
	update_homebrew
	bar "=" 90

	bar "=" 90 "Updating Python..."
	update_python
	bar "="
}

function update_homebrew() {
	bar "-" 80 "Removing outdated formulas..."
	brew cleanup -n
	bar "-" 80 "Updating packages..."
	brew upgrade
}

function update_python() {
	local CUR=$(pyenv version | sed 's/\(^[0-9.]*\).*/\1/')
	local NEW=$(pyenv install -l | sed 's/^  //g' | egrep '^[0-9.]*$' | tail -n 1)

	if [[ "${CUR}" != "" ]] && [[ "${NEW}" != "" ]] && [[ "${CUR}" != "${NEW}" ]]; then
		pyenv install "${NEW}"
		pyenv global "${NEW}"
	fi
}

function update_onload() {
	local UPDATE_LOG="${HOME}/.update_log"
	local LAST_UPDATED_DATE="$(cat ${UPDATE_LOG} | tail -n 1)"
	local TODAY="$(date '+%Y-%m-%d')"

	if [ ! -f "${UPDATE_LOG}" ]; then
		update_all
		touch ${UPDATE_LOG}
		echo "${TODAY}" >>${UPDATE_LOG}
	fi

	if [[ "${LAST_UPDATED_DATE}" < "${TODAY}" ]]; then
		update_all
		echo "${TODAY}" >>${UPDATE_LOG}
	fi
}

# Run on load
update_onload
