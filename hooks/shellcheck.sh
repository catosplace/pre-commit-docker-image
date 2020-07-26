#!/usr/bin/env bash

set -e

exit_status=0

# for FILE in $files; do
for FILE in $@; do
	SHEBANG_REGEX='^#!\(/\|/.*/\|/.* \)\(\(ba\|da\|k\|a\)*sh\|bats\)$'
	if (head -1 "$FILE" | grep "$SHEBANG_REGEX" >/dev/null); then
		# if ! shellcheck "$FILE"; then
		if !(dojo -i false "shellcheck -x $FILE"); then
			exit_status=1
		fi
	elif (head -1 "$FILE" | grep "# shellcheck shell=bash" >/dev/null); then
	    if !(dojo -i false "shellcheck -x $FILE"); then
			exit_status=1
		fi
	elif [[ "$FILE" =~ .+\.(sh|bash|dash|ksh|ash|bats)$ ]]; then
		echo "$FILE: missing shebang"
		exit_status=1
	fi
done

exit $exit_status