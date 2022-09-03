#!/usr/bin/env bash

USER_SYSTEMD=$HOME/.config/systemd/user

mkdir -p $USER_SYSTEMD

rm $USER_SYSTEMD/email-status-updates.service
rm $USER_SYSTEMD/email-status-updates.timer

cp `realpath ./email-status-updates.service` $USER_SYSTEMD
cp `realpath ./email-status-updates.timer`   $USER_SYSTEMD

systemctl --user daemon-reload

systemctl --user enable email-status-updates.timer
systemctl --user start email-status-updates.timer
