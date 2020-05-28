#!/bin/bash
cd "$(dirname "$0")"

HEAP_SIZE=4096
JAR_NAME=/home/minecraft/server/forge-*.jar

# Set env
sed -i s/rcon.password=\.*/rcon.password=${RCON_PASSWORD:=creeper}/ server.properties

# Launch the server.
CMD="java -Xms${HEAP_SIZE}M -Xmx${HEAP_SIZE}M -jar ${JAR_NAME}"
echo "launching server with command line: ${CMD}"
${CMD}
