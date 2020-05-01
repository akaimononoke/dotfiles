alias ua='update_all'

UPDATE_HISTORY="${HOME}/.update_history"
PIP_MODULES="${HOME}/.pip_modules"

function update_all() {
	message "*** UPDATE ***" $(color bold blue) &&
		update_homebrew &&
		update_python &&
		# update_pip &&
		message "*** UPDATE ***" $(color bold blue)
}

function update_homebrew() {
	message "[Homebrew]" $(color bold blue)

	message "Removing outdated formulas..." $(color blue)
	brew cleanup

	message "Updating packages..." $(color blue)
	brew upgrade

	message "Complete." $(color blue)
}

function update_python() {
	message "[Python]" $(color bold blue)

	local CUR=$(pyenv version | sed 's/\(^[0-9.]*\).*/\1/')
	local NEW=$(pyenv install -l | sed 's/^  //g' | egrep '^[0-9.]*$' | tail -n 1)

	if [[ "${CUR}" != "" ]] && [[ "${NEW}" != "" ]] && [[ "${CUR}" != "${NEW}" ]]; then
		pyenv install "${NEW}"
		pyenv global "${NEW}"
	fi

	message "Complete." $(color blue)
}

function update_pip() {
	message "[pip]" $(color bold blue)

	message "Updating pip itself..." $(color blue)
	python -m pip install --upgrade pip

	message "Updating pip modules..." $(color blue)
	local OUTDATED_MODULES=($(pip_list_outdated))
	if [ ${#OUTDATED_MODULES[*]} -eq 0 ]; then
		message "No outdated modules."
	else
		message "Modules to be updated: ${OUTDATED_MODULES[*]}"
		for MODULE in ${OUTDATED_MODULES[*]}; do
			pip install -U "${MODULE}"
		done
	fi

	message "Fixing broken dependencies..." $(color blue)
	local BROKEN_DEPENDENCIES=($(pip_check))
	while [ ${#BROKEN_DEPENDENCIES[*]} -gt 0 ]; do
		for MODULE in ${BROKEN_DEPENDENCIES[*]}; do
			pip install ${MODULE}
		done
		BROKEN_DEPENDENCIES=($(pip_check))
	done

	message "Save module list to ~/pip_modules.txt..." $(color blue)
	sudo pip list -l --format freeze >${PIP_MODULES}

	message "Complete." $(color blue)
}

function pip_list_outdated() {
	pip list -o --format=freeze --disable-pip-version-check --no-python-version-warning | sed 's/==.*//g'
}

function pip_check() {
	pip check --disable-pip-version-check --no-python-version-warning | awk -F ' ' '{print $5}' | sed 's/,//g'
}

function update_onload() {
	local LAST_UPDATED_DATE="$(cat ${UPDATE_HISTORY} | tail -n 1)"
	local TODAY="$(date '+%Y-%m-%d')"

	if [ ! -f "${UPDATE_HISTORY}" ]; then
		update_all
		touch ${UPDATE_HISTORY}
		echo "${TODAY}" >>${UPDATE_HISTORY}
	fi

	if [[ "${LAST_UPDATED_DATE}" < "${TODAY}" ]]; then
		update_all
		echo "${TODAY}" >>${UPDATE_HISTORY}
	fi
}
