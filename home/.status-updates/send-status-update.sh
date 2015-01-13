#!/usr/bin/env bash

TO_EMAILS=$(< recipients.conf)

TODAYS_MESSAGE_FILE="message/status/$(date +%d-%m-%Y).txt"

TEMPLATE="$(< message/template.txt)"
DEFAULT_MESSAGE="$(< message/default.txt)"

if [[ -f "$TODAYS_MESSAGE_FILE" ]]; then
	MESSAGE="$(cat $TODAYS_STATUS_MESSAGE_FILE | sed -e 's/^ *//' -e 's/ *$//')"
else
	MESSAGE+""
fi


if [[ -z "$MESSAGE" ]]; then
	MESSAGE=$DEFAULT_MESSAGE
fi

COMPLETE_MESSAGE=$(printf "$TEMPLATE" "$MESSAGE")

echo "$COMPLETE_MESSAGE" | mail \
	-s "Status and Deploy Update for $(date +%D)" \
	${TO_EMAILS}
