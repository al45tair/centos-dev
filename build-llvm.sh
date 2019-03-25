export PATH=/usr/local/gcc/bin:/usr/local/python/bin:/usr/local/cmake/bin:$PATH

# Now build llvm and clang
cd /src/llvm-project
mkdir build
cd build
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_C_COMPILER=/usr/local/bin/gcc \
      -DCMAKE_CXX_COMPILER=/usr/local/bin/g++ \
      -DCMAKE_INSTALL_PREFIX=/usr/local/ \
      -DLLVM_ENABLE_PROJECTS="clang;libcxx;libcxxabi" \
      ../llvm
make -j$PARALLELISM && make install
