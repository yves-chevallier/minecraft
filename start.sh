#!/bin/bash

HEAP_SIZE=4096
JAR_NAME=/home/minecraft/server/forge-*.jar

# Launch the server.
CMD="java -Xms${HEAP_SIZE}M -Xmx${HEAP_SIZE}M -jar ${JAR_NAME}"
echo "launching server with command line: ${CMD}"
${CMD}
