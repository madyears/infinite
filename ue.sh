#!/bin/sh

ue () {
	echo "$@" | xxd -ps | sed 's/\([a-f0-9][a-f0-9]\)/%\1/g'
}

if [ $# -eq 0 ]; then
	while read line ; do
		ue $line
	done
else
	ue $@
fi

