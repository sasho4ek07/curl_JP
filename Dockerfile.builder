FROM alpine:3.15 as build
RUN apk add autoconf automake libtool binutils build-base git
RUN addgroup -S builder && adduser -S builder -G builder -D
USER builder

# RUN cd && git clone https://github.com/curl/curl.git
# RUN cd /home/builder/curl && autoreconf -fi && ./configure --without-ssl --disable-shared --disable-thread && make
