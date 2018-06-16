#!/bin/bash

[ -z "$INCLUDE_GUARD" ] && export INCLUDE_GUARD="INCLUDE_GUARD"

script_include()
{
	local script_script_space_list="$1"
	local script_source=""

	for script_script in $script_script_space_list ; do

        export SOURCE_DIR=${SOURCE_DIR:-""}
        if [ -n "$SOURCE_DIR" ] ; then
                # normailize to many slashes to just one
                SOURCE_DIR=$(echo "$SOURCE_DIR" | sed -E 's/\/+$//')
                SOURCE_DIR="${SOURCE_DIR}/"
                echo "[W] SOURCE_DIR set to: \"$SOURCE_DIR\""
        else
                SOURCE_DIR="."
                echo "[*] SOURCE_DIR set to: \"$SOURCE_DIR\""
        fi

		script_source="${SOURCE_DIR}/$script_script"

        local do_the_include=""
        do_the_include=0

		if [ -r "$script_source" ]  ; then

            mystring="$INCLUDE_GUARD"
            substring="${script_source}"
            if [[ "$mystring" = "INCLUDE_GUARD" ]] ; then
                export INCLUDE_GUARD
                INCLUDE_GUARD="$( dirname "${BASH_SOURCE[0]}" )/includer.sh" # include includer
                do_the_include=1
            else
                if [ "${mystring/${substring}}" = ${mystring} ] ; then
                    do_the_include=1
                fi
            fi

            if [ $do_the_include -eq 1 ]; then # need to inlucde it
                export INCLUDE_GUARD="$INCLUDE_GUARD:$script_source"
            fi

			#echo "[*] Sourcing: $script_source"
			source "$script_source"

		else
            echo "SOURCE_DIR: \"$SOURCE_DIR\""
			ls -ld "$SOURCE_DIR"
			file "$SOURCE_DIR"
			echo "[F] Couldn't source: $script_source"
			exit 42
		fi
	done
}

