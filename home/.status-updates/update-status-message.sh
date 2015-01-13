#!/usr/bin/env bash

TODAYS_MESSAGE_FILE="$HOME/.status-updates/message/status/$(date +%d-%m-%Y).txt"

TEMPORARY_FILE="$(mktemp --suffix StatusUpdate)"

touch "$TODAYS_MESSAGE_FILE"

cat "$TODAYS_MESSAGE_FILE" > "$TEMPORARY_FILE"

if [[ -z "$1" ]]; then
	if [[ -z "$EDITOR" ]]; then
		vi "$TEMPORARY_FILE"
	else
		$EDITOR "$TEMPORARY_FILE"
	fi
else
	echo "$1" >> "$TEMPORARY_FILE"
fi

cat "$TEMPORARY_FILE" > "$TODAYS_MESSAGE_FILE"

rm "$TEMPORARY_FILE"
