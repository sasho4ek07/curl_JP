FROM alpine:3.15 as build
USER root
RUN apk add autoconf automake libtool binutils build-base git