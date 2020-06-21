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

# Get mods
RUN mkdir -p server/mods
RUN cd server/mods && jq .installedAddons[].installedFile.downloadUrl ../minecraftinstance.json | xargs -n1 curl -SL -O

# Remove non-mod
COPY non-mod .
RUN cat non-mod | xargs -n1 -I{} bash -c 'rm -vf server/mods/{}'

# Copy server config
COPY server/eula.txt server/eula.txt
COPY server/server.properties server/server.properties
COPY server/config server/config

# Update permissions
RUN chown -R minecraft:minecraft ${HOMEDIR}

# Mcrcon
RUN apk add --no-cache -U make gcc libc-dev moreutils
RUN git clone https://github.com/Tiiffi/mcrcon.git
RUN cd mcrcon && make && make install && rm -rf mcrcon

# Backup
ADD crontab.txt crontab.txt
ADD backup.sh backup.sh
RUN /usr/bin/crontab ./crontab.txt

# Ports
EXPOSE 25565 25575

# Entrypoint
ADD start.sh server/
RUN chmod +x server/start.sh
RUN chmod +x backup.sh

ENTRYPOINT [ "server/start.sh" ]
