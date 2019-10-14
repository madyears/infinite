#!/bin/sh

f () {
	basename $1 | rev | cut -d. -f2- | rev | sed 's/ /./g'
}

pn=$(f $0)

if [ $# -lt 1 -o $# -gt 2 ]; then
	echo Usage: $pn branch-name [index]
	git branch
	exit 1
elif [ "$1" == "-" ]; then
	git checkout -
	exit 0
fi

fb=$(git branch | grep $1 | grep -o -E '\<[A-Za-z0-9]*\>')
bc=$(echo "$fb" | wc -l)

if [ -n "$fb" ]; then
	if [ $bc -eq 1 ]; then
		git checkout $fb
		exit 0
	elif [ $bc -gt 1 ]; then
		if [ -z $2 ]; then
			echo "$fb" | nl
			echo "Run \`$pn $1 index\`"
			exit 2
		fi
		sb=$(echo "$fb" | awk -v i=$2 'NR==i')
		git checkout $sb
	fi
else
	echo No branch found matching $1
fi
