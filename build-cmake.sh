export PATH=/usr/local/gcc/bin:$PATH

# Build cmake
cd /src/cmake-$CMAKEVER
./bootstrap CC=/usr/local/bin/gcc CXX=/usr/local/bin/g++
make -j$PARALLELISM && make install
