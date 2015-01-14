#!/usr/bin/env bash
CONFIGURATION_FILE="$HOME/.status-updates/status-updates.conf"

TEMPLATE_FILE="$HOME/.status-updates/message/template.txt"
DEFAULT_MESSAGE_FILE="$HOME/.status-updates/message/default.txt"
TODAYS_MESSAGE_FILE="$HOME/.status-updates/message/status/$(date +%d-%m-%Y).txt"

if [ ! -f "$CONFIGURATION_FILE" ]; then
	echo "Error: configuration file missing"
	exit
fi

. "$CONFIGURATION_FILE"

TEMPLATE="$(< $TEMPLATE_FILE)"
DEFAULT_MESSAGE="$(< $DEFAULT_MESSAGE_FILE)"

if [[ -f "$TODAYS_MESSAGE_FILE" ]]; then
	MESSAGE="$(cat $TODAYS_MESSAGE_FILE | sed -e 's/^ *//' -e 's/ *$//')"
else
	MESSAGE=""
fi

if [[ -z "$MESSAGE" ]]; then
	MESSAGE="$DEFAULT_MESSAGE"
fi

if [[ -z "$SUBJECT" ]]; then
	SUBJECT="Status Update for %D"
fi

SUBJECT=$(date +"$SUBJECT")

COMPLETE_MESSAGE=$(printf "$TEMPLATE" "$MESSAGE")

if [[ -z "$TO_EMAILS" ]]; then
	echo "Error: No emails to send to"

	exit 1
fi

echo "Sending status update to ${TO_EMAILS}"

echo "$COMPLETE_MESSAGE" | mail \
	-s "$SUBJECT" \
	-b "${BCC_EMAILS}" \
	"${TO_EMAILS}"

exit $?
