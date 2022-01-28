cd curl
# CC="/usr/local/bin/x86_64-linux-musl-gcc -static" 
# LD="/usr/local/bin/x86_64-linux-musl-ld -static" 
# AR="/usr/local/bin/x86_64-linux-musl-ar -static" 
# RANLIB="/usr/local/bin/x86_64-linux-musl-ranlib" 
# PERL="/usr/bin/perl"
# PKG_CONFIG="pkg-config --static" 
autoreconf -fi
./configure \
--without-ssl \
#--disable-thread \
# --disable-zlib --without-zlib \
--disable-shared --enable-static \
# --disable-ldap --disable-sspi \
# --without-librtmp --disable-ftp \
# --disable-file --disable-dict \
# --disable-telnet --disable-tftp \
# --disable-manual --disable-ldaps \
# --disable-dependency-tracking \
# --disable-librtsp --disable-pop3 \
# --disable-imap --disable-smtp \
# --disable-gopher --disable-smb \
# --without-libidn --disable-proxy \
# --disable-verbose --host=x86_64-linux
make curl_LDFLAGS=-all-static
