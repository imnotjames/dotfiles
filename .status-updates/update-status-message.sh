#!/usr/bin/env bash

CHOSEN_DATE="$(date +%d-%m-%Y)"
MESSAGE=""

OPTIONS=`getopt -o hd:m: --long help,date:,message: -n "update-status-message" -- "$@"`

if [[ "$?" -ne "0" ]]; then	
	exit
fi

eval set -- "$OPTIONS"

while true; do
	case "$1" in
		-h|--help)
			echo "update-status-message [-d date-string] [-m message]"

			exit 1
			;;

		-d|--date)
			CHOSEN_DATE="$(date --date="$2" +%d-%m-%Y)"

			if [[ "$?" != "0" ]]; then
				exit 1
			fi

			shift 2
			;;
		-m|--message)
			MESSAGE="$2"
			shift 2
			;;
		"--")
			shift
			break
			;;
		*)
			echo "Internal error: $1"
			exit 1
			;;
	esac
done

CHOSEN_MESSAGE_FILE="$HOME/.status-updates/message/status/$CHOSEN_DATE.txt"
EDITOR_MESSAGE_FILE="$HOME/.status-updates/message/status-editor-message.txt"

TEMPORARY_FILE="$(mktemp --suffix StatusUpdate)"

touch "$CHOSEN_MESSAGE_FILE"

cat "$EDITOR_MESSAGE_FILE" >> "$TEMPORARY_FILE"
cat "$CHOSEN_MESSAGE_FILE" >> "$TEMPORARY_FILE"

if [[ -z "$MESSAGE" ]]; then
	if [[ -z "$EDITOR" ]]; then
		vi "$TEMPORARY_FILE"
	else
		$EDITOR "$TEMPORARY_FILE"
	fi
else
	echo "$MESSAGE" >> "$TEMPORARY_FILE"
fi

cat "$TEMPORARY_FILE" \
	| grep -v '^\s*#' \
	| sed '/^$/N;/\n$/D' \
	> "$CHOSEN_MESSAGE_FILE"

rm "$TEMPORARY_FILE"
