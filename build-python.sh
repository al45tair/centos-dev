export PATH=/usr/local/gcc/bin:$PATH

# Install Python
cd /src/Python-$PYTHONVER
./configure --enable-optimizations
make -j$PARALLELISM && make install
