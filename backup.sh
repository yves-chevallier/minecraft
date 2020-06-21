#!/bin/bash
DAYS_RETENTION=7
HOME=/home/minecraft

mcrcon "say Saves are disabled" save-off
mcrcon "say Starting daily backup" save-all
sleep 3
tar -cvpzf ${HOME}/backups/server-$(date +%F-%H-%M).tar.gz ${HOME}/server
sleep 1
mcrcon -w 5 "say Saves are now enabled" save-on

## Delete older backups
find ${HOME}/backups/ -type f -mtime +${DAYS_RETENTION} -name '*.gz' -delete
