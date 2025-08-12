# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./build
cp $BUILD_PREFIX/share/gnuconfig/config.* ./contrib/ldapc++
set -x
# export CPPFLAGS="${CPPFLAGS} -isystem $PREFIX/include "
export ac_cv_func_memcmp_working=yes
if [[ "$(uname)" == "Darwin" ]]; then
  export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"
fi

if [ `uname -m` == ppc64le ]; then
    # libsasl2 from defaults needs this when building on POWER
    export LIBS="-ldl"
fi

# --disable-slaped: don't build server components
# --disable-slurpd: deprecated; removed in OpenLDAP 2.4
# --enable-ipv6: welcome to the future!
# --with-cyrus-sasl: required for full LDAPv3 compliance
# --with-tls openssl: required for full LDAPv3 compliance
./configure \
    --prefix=$PREFIX  \
    --disable-slapd \
    --enable-ipv6 \
    --with-cyrus-sasl \
    --with-tls=openssl \
    --with-yielding_select=yes \
    || { cat config.log; exit 1; }
make -j${CPU_COUNT}
make test
make install
