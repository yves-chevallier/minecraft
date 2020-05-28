FROM adoptopenjdk/openjdk9-openj9:alpine

LABEL maintainer "nowox"

RUN apk add --no-cache -U \
  openssl \
  git \
  vi \
  bash \
  wget \
  git \
  sudo \

RUN addgroup -g 1000 minecraft
RUN adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft
RUN mkdir -m 777 /data
RUN chown minecraft:minecraft /data /home/minecraft

COPY files/sudoers* /etc/sudoers.d

EXPOSE 25565 25575
