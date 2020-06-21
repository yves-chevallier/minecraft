#!/bin/bash
cd "$(dirname "$0")"
HOME=/home/minecraft

# Settings from environment
sed -iE s/\(rcon.password\).*$/\\1=${RCON_PASSWORD}/ ${HOME}/server/server.properties
export MCRCON_HOST=127.0.0.1
export MCRCON_PORT=25575
export MCRCON_PASS=${RCON_PASSWORD}

# Run backup
/usr/sbin/crond

# Run Minecraft Server
JAR_NAME=${HOME}//server/forge-*.jar
CMD="java -Xms${HEAP_SIZE}M -Xmx${HEAP_SIZE}M -jar ${JAR_NAME}"
${CMD}
