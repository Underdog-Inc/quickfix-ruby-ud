FROM ghcr.io/rake-compiler/rake-compiler-dock-image:1.11.1-mri-x86_64-linux

RUN apt-get update && \
    apt-get install -y libpq-dev build-essential libssl-dev

RUN ln -s /usr/include/$(dpkg-architecture -qDEB_HOST_MULTIARCH)/openssl/opensslconf.h /usr/include/openssl/
