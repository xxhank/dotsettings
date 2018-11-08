#!/usr/bin/env bash

#IFS=$'\n'

set -euo pipefail
# set -o xtrace

declare -r script_path="${BASH_SOURCE[0]}"
declare -r script_dir="${script_path%/*}"
declare -r script_file="${script_path##*/}"

method=${1:-main}

if [[ $method == "find" ]]; then
	echo "link: $*"
	source_file="$2"
	target_dir="$3"

	source_name="$(basename "$source_file")"
	if [[ -e "$target_dir/$source_name" ]]; then
		echo "$target_dir/$source_name exist"
	else
		echo "$target_dir/$source_name not exist"
		ln -s "$source_file" "$target_dir"
	fi	
else
	echo "find"
	find "Application Support" -depth 1 -exec "$script_path" help "{}" "$HOME/Library/Application Support" \;
fi

