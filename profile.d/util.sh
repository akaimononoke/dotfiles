function message() {
	local message="$1"
	local color="$2"
	printf "${color}${message}$(color)\n"
}

function now() {
	date '+%Y-%m-%d %H:%M:%S'
}

function rmindexmd() { find . -type f -regex '^.*/index.md$' | xargs rm; }

function findmd() { find . -type f -regex '^.*\.\(md\)$'; }

function mkindexmd() {
	rmindexmd

	paths=($(findmd))
	baseurl="${1%/}"
	index_md="/index.md"

	for p in ${paths[*]}; do
		basename="/$(basename "${p}")"
		filename="$(basename "${p}" | cut -d '.' -f1)"

		dir="$(dirname "${p}" | sed -e "s/^$(pwd | sed -e 's/\//\\\//g' -e 's/\./\\\./g')//" -e 's/^\.//')"
		dir="${dir%/}"
		index_path="$(pwd)${dir}${index_md}"
		index_url="${baseurl}${dir}${index_md}"
		file_url="${baseurl}${dir}${basename}"

		par_basename="$(basename "${dir}")"
		par_dir="$(dirname "${dir}" | sed -e "s/^$(pwd | sed -e 's/\//\\\//g' -e 's/\./\\\./g')//" -e 's/^\.//')"
		par_dir="${par_dir%/}"
		par_index_path="$(pwd)${par_dir}${index_md}"
		par_index_url="${baseurl}${par_dir}${index_md}"

		file_url_md="- **[${filename}](${file_url})**"
		index_url_md="- *[${par_basename}](${index_url})*"

		if [ "${par_basename}" != "" ] && ([ ! -f "${par_index_path}" ] || ! grep "${index_url}" <"${par_index_path}" >/dev/null); then
			echo "${index_url_md}" >>${par_index_path}
		fi

		echo "${file_url_md}" >>${index_path}
	done
}
