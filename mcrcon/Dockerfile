FROM alpine:latest

RUN apk add git
RUN apk add build-base

RUN git clone https://github.com/Tiiffi/mcrcon.git
RUN cd mcrcon && make && make install

ENTRYPOINT [ "mcrcon" ]
