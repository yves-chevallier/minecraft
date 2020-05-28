FROM adoptopenjdk/openjdk9-openj9:alpine

ENV HOMEDIR /home/minecraft

LABEL maintainer "nowox"

# Required packages
RUN apk add --no-cache -U git vi bash curl sudo

# User minecraft
RUN addgroup -g 1000 minecraft
RUN adduser -Ss /bin/false -u 1000 -G minecraft -h ${HOMEDIR} minecraft

# Get Forge
RUN cd ${HOMEDIR}/server && jq .baseModLoader.downloadUrl ../minecraftinstance.json | xargs curl -sOSL

# Get mods
RUN mkdir -p ${HOMEDIR}/server/mods
RUN cd ${HOMEDIR}/server/mods && jq .installedAddons[].installedFile.downloadUrl ../../minecraftinstance.json | xargs curl -sOSL

# Update permissions
RUN chown -r minecraft:minecraft ${HOMEDIR}

EXPOSE 25565 25575

ENTRYPOINT [ "/start" ]
