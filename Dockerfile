FROM ruby:3.3.0-alpine3.18

ARG BUNDLE_GITHUB__COM
ENV BUNDLE_GITHUB__COM=$BUNDLE_GITHUB__COM

RUN apk add --no-cache \
      git \
      postgresql15-dev \
      postgresql15 \
      libtool \
      m4 \
      autoconf \
      automake \
      bash \
      build-base \
      ruby-dev

# unknown dev deps
#      shared-mime-info \
#      jemalloc \
#      gcompat \
#      libcurl \
#      curl-dev \
#      libffi-dev \
#      libsodium \
#      libxml2 \
#      libxml2-dev \
#      libxslt \
#      libxslt-dev \
#      build-base \
#      chromium \
#      chromium-chromedriver \

RUN gem install rake-compiler
    
WORKDIR /build
COPY . ./
RUN chmod +x install_quickfix.sh
RUN ./install_quickfix.sh

