FROM alpine:latest

RUN apk add --no-cache git build-base

RUN git clone https://github.com/Tiiffi/mcrcon.git
RUN cd mcrcon && make && make install

RUN apk del git build-base

ENTRYPOINT [ "mcrcon" ]
