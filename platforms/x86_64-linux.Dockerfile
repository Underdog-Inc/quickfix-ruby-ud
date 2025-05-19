FROM ghcr.io/rake-compiler/rake-compiler-dock-image:1.9.1-mri-x86_64-linux

RUN apt-get update && \
    apt-get install -y libpq-dev build-essential libssl-dev
