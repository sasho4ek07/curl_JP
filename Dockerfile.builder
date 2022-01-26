FROM alpine:3.15 as build
RUN apk add --no-cache autoconf automake libtool binutils build-base
# RUN addgroup -S builder && adduser -S builder -G builder -D
# USER builder
# RUN mkdir /home/builder/curl
WORKDIR /tmp/curl
COPY ./run_build.sh /tmp/curl/run_build.sh
COPY ./curl /tmp/curl

# RUN cd /home/builder/curl && autoreconf -fi && ./configure --without-ssl --disable-shared --disable-thread && make
