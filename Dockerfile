FROM ubuntu:21.04

LABEL maintainer="haoyuan"

COPY OSLab /

RUN apt-get update || apt-get update                                       \ 
    && DEBIAN_FRONTEND=noninteractive apt-get -y install   autoconf        \
                                                           automake        \
                                                           autotools-dev   \
                                                           curl            \
                                                           python3         \
                                                           libmpc-dev      \
                                                           libmpfr-dev     \
                                                           libgmp-dev      \
                                                           gawk            \
                                                           build-essential \
                                                           bison           \
                                                           flex            \
                                                           texinfo         \
                                                           gperf           \
                                                           libtool         \
                                                           patchutils      \
                                                           bc              \
                                                           zlib1g-dev      \
                                                           libexpat-dev    \
                                                           vim             \
                                                           tmux            \
                                                           pkg-config      \
                                                           libglib2.0-dev  \
                                                           libpixman-1-dev \
                                                           libsdl2-2.0     \
                                                           libsdl2-dev     \
    && echo "usr/local/lib" >> /etc/ld.so.conf

ENV PATH="$PATH:/opt/riscv64-unknown-linux-gnu/bin"


