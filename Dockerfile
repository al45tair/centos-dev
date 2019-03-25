#
# Build up a build environment
#
FROM centos:6 AS builder

# Parameters
ARG PARALLELISM=4
ENV PYTHONVER=2.7.16
ENV GCCVER=8.3.0
ENV CMAKEVER=3.14.0
ENV LLVMVER=8.0.0

# First install some Centos packages
RUN yum install -y svn git wget

# Fetch the sources for GCC, Python, Cmake and LLVM
ADD fetch-srcs.sh /src/
RUN /bin/sh src/fetch-srcs.sh

# Install a few additional Centos packages
RUN yum install -y gcc gcc-c++ readline-devel zlib-devel bzip2-devel openssl-devel flex zip texinfo info

# Build GCC first
ADD build-gcc.sh /src/
RUN /bin/sh src/build-gcc.sh

# Build Python
ADD build-python.sh /src/
RUN /bin/sh src/build-python.sh

# Build Cmake
ADD build-cmake.sh /src/
RUN /bin/sh src/build-cmake.sh

# Build LLVM
ADD build-llvm.sh /src/
RUN /bin/sh src/build-llvm.sh

# Finally, copy across the tools we built
FROM centos:6

RUN yum install -y glibc-devel libstdc++-devel readline-devel zlib-devel bzip2-devel openssl-devel git

# Copy the built software over
COPY --from=builder /usr/local/ /usr/local/
RUN echo "/usr/local/lib64" > /etc/ld.so.conf.d/usr-local-lib.conf \
    && echo "/usr/local/lib" >> /etc/ld.so.conf.d/usr-local-lib.conf \
    && ldconfig
