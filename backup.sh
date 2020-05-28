#!/bin/bash
DAYS_RETENTION=7
HOME=${HOME}

function rcon {
  ${HOME}/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p ${RCON_PASSWORD} "$1"
}

rcon "save-off"
rcon "save-all"
tar -cvpzf ${HOME}/backups/server-$(date +%F-%H-%M).tar.gz ${HOME}/server
rcon "save-on"

## Delete older backups
find ${HOME}/backups/ -type f -mtime +${DAYS_RETENTION} -name '*.gz' -delete
