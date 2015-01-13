#!/usr/bin/env bash

USER_SYSTEMD=$HOME/.config/systemd/user

mkdir -p $USER_SYSTEMD

systemctl --user daemon-reload

ln -sf $(realpath ./email-status-updates.service)   $USER_SYSTEMD

systemctl --user enable $(realpath ./email-status-updates.timer)
