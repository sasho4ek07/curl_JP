FROM alpine:3.15 as build
RUN apk add --no-cache autoconf automake libtool binutils build-base

# WORKDIR /tmp/curl
# COPY --chmod=755 ./run_build.sh /tmp/curl/run_build.sh
# COPY ./curl /tmp/curl
