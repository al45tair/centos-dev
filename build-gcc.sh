# Build GCC
cd /src
gccver=`echo $GCCVER | tr . _`
mkdir gcc_build
cd gcc_build
../gcc/configure --disable-multilib
make -j$PARALLELISM && make install

echo "/usr/local/lib64" > /etc/ld.so.conf.d/usr-local-lib.conf
echo "/usr/local/lib" >> /etc/ld.so.conf.d/usr-local-lib.conf
ldconfig
