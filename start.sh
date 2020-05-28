#!/bin/bash

#
# Properly tunes a Minecraft server to run efficiently under the
# OpenJ9 (https://www.eclipse.org/openj9) JVM.
#
# Licensed under the MIT license.
#

## BEGIN CONFIGURATION

# HEAP_SIZE: This is how much heap (in MB) you plan to allocate
#            to your server. By default, this is set to 4096MB,
#            or 4GB.
HEAP_SIZE=4096

# JAR_NAME:  The name of your server's JAR file. The default is
#            "paperclip.jar".
#
#            Side note: if you're not using Paper (http://papermc.io),
#            then you should really switch.
JAR_NAME=/home/minecraft/server/forge-*.jar

## END CONFIGURATION -- DON'T TOUCH ANYTHING BELOW THIS LINE!

## BEGIN SCRIPT

# Compute the nursery size.
NURSERY_MINIMUM=$(($HEAP_SIZE / 2))
NURSERY_MAXIMUM=$(($HEAP_SIZE * 4 / 5))

# Launch the server.
CMD="java -Xms${HEAP_SIZE}M -Xmx${HEAP_SIZE}M -Xmns${NURSERY_MINIMUM}M -Xmnx${NURSERY_MAXIMUM}M -Xgc:concurrentScavenge -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:scvNoAdaptiveTenure -Xdisableexplicitgc -jar ${JAR_NAME}"
echo "launching server with command line: ${CMD}"
${CMD}
