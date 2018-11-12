#!/usr/bin/env bash

#IFS=$'\n'

set -euo pipefail
# set -o xtrace

declare -r script_path="${BASH_SOURCE[0]}"
declare -r script_dir="${script_path%/*}"
declare -r script_file="${script_path##*/}"

method=${1:-find}

if [[ $method == "help" ]]; then
	echo "\$1: $1"
	echo "\$2: $2"
	echo "\$3: $3"

	source_file="$2"
	target_dir="$3"

	if [[ ! -e "${source_file}" ]]; then
		echo "source '${source_file}' not exist"
		exit 1
	fi

	source_name="$(basename "$source_file")"
	if [[ -e "$target_dir/$source_name" ]]; then
		echo "$target_dir/$source_name exist"
		if [[ ! -e "$target_dir/$source_name.1" ]]; then
			mv "$target_dir/$source_name" "$target_dir/$source_name.1"
		fi
		ln -s "$source_file" "$target_dir"
	else
		echo "$target_dir/$source_name not exist"
		ln -s "$source_file" "$target_dir"
	fi
else
	echo "find"
	find "$PWD/Application Support" -depth 1 -exec "$script_path" help "{}" "$HOME/Library/Application Support" \;
fi

