FROM ghcr.io/rake-compiler/rake-compiler-dock-image:1.9.1-mri-aarch64-linux

RUN apt-get update && \
    apt-get install -y libpq-dev build-essential libssl-dev

RUN sudo ln -s /usr/include/x86_64-linux-gnu/openssl/opensslconf.h /usr/include/openssl/
