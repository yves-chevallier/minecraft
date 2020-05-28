FROM openjdk:8u212-jre-alpine

WORKDIR /home/minecraft
ENV HOMEDIR /home/minecraft

LABEL maintainer "nowox"

# Required packages
RUN apk add --no-cache -U git jq vim bash curl sudo

# User minecraft
RUN addgroup -g 1000 minecraft
RUN adduser -Ss /bin/false -u 1000 -G minecraft -h ${HOMEDIR} minecraft

# Get Forge
RUN mkdir -p server
COPY minecraftinstance.json server
RUN cd server && jq .baseModLoader.downloadUrl minecraftinstance.json | sed s/.jar/-installer.jar/ | xargs curl -SL -O

# Install server
RUN cd server && java -jar *-installer.jar --installServer
RUN rm server/*-installer.*
COPY server/eula.txt server
COPY server/server.properties server

# Get mods
RUN mkdir -p server/mods
RUN cd server/mods && jq .installedAddons[].installedFile.downloadUrl ../minecraftinstance.json | xargs -n1 curl -SL -O

# Copy server config
COPY server/config server/config

# Update permissions
RUN chown -R minecraft:minecraft ${HOMEDIR}

EXPOSE 25565 25575

COPY start.sh server/
RUN chmod +x server/start.sh

ENTRYPOINT [ "server/start.sh" ]
