function rmindexmd() { find . -type f -regex '^.*/index.md$' | xargs rm; }

function findmd() { find . -type f -regex '^.*\.\(md\)$'; }

function mkindexmd() {
    # remove existing index.md
    rmindexmd

    baseurl="${1%/}"
    index="/index.md"
    index_filename="/$(basename "${index}" | cut -d '.' -f1)"

    for p in $(findmd); do
        filename="$(basename "${p}" | cut -d '.' -f1)"

        dir="$(dirname "${p}" | sed -e "s/^$(pwd | sed -e 's/\//\\\//g' -e 's/\./\\\./g')//" -e 's/^\.//')"
        dir="${dir%/}"

        index_path="$(pwd)${dir}${index}"
        index_url="${baseurl}${dir}${index_filename}"
        file_url="${baseurl}${dir}/${filename}"

        par_basename="$(basename "${dir}")"
        par_dir="$(dirname "${dir}" | sed -e "s/^$(pwd | sed -e 's/\//\\\//g' -e 's/\./\\\./g')//" -e 's/^\.//')"
        par_dir="${par_dir%/}"
        par_index_path="$(pwd)${par_dir}${index}"
        par_index_url="${baseurl}${par_dir}${index_filename}"

        file_url_md="- **[${filename}](${file_url})**"
        index_url_md="- [${par_basename} /](${index_url})"

        if [ "${par_basename}" != "" ] && ([ ! -f "${par_index_path}" ] || ! grep "${index_url}" <"${par_index_path}" >/dev/null); then
            echo "${index_url_md}" >>${par_index_path}
            echo "$(color magenta)${index_url}$(color) -> $(color blue)${par_index_path}$(color)"
        fi

        echo "${file_url_md}" >>${index_path}
        echo "$(color magenta)${file_url}$(color) -> $(color blue)${index_path}$(color)"
    done
}
