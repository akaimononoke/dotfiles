alias ua='update_all'

function update_all() {
	update_homebrew && update_python
}

function update_homebrew() {
	message "Updating Homebrew..."

	message "Removing outdated formulas..."
	brew cleanup
	message "Updating packages..."
	brew upgrade

	message "Completed."
}

function update_python() {
	message "Updating Python..."

	local CUR=$(pyenv version | sed 's/\(^[0-9.]*\).*/\1/')
	local NEW=$(pyenv install -l | sed 's/^  //g' | egrep '^[0-9.]*$' | tail -n 1)

	if [[ "${CUR}" != "" ]] && [[ "${NEW}" != "" ]] && [[ "${CUR}" != "${NEW}" ]]; then
		pyenv install "${NEW}"
		pyenv global "${NEW}"
	fi

	message "Completed."
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
