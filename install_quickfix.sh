#!/bin/sh

set -e 

coreutils_installed() {
  command -v greadlink >/dev/null 2>&1 || command -v readlink >/dev/null 2>&1
}

install_coreutils() {
  if coreutils_installed; then
    echo "coreutils already installed, skipping"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing coreutils via Homebrew..."
    brew install coreutils
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Installing coreutils via apk..."
    apk add --no-cache coreutils
  else
    echo "Unsupported OS: $OSTYPE"
    exit 1
  fi
}

build_quickfix_source(){
  git clone --depth 1 https://github.com/Underdog-Inc/quickfix.git
  rm -rf quickfix/.git
  
  cd quickfix
  ./bootstrap
  ./configure --with-ruby --with-openssl="$openssl_dir" --with-postgresql
  make HAVE_SSL=1 HAVE_POSTGRESQL=1
  cd ..
}

copy_source_files(){
  mkdir -p lib
  mkdir -p ext/quickfix
  mkdir -p ext/quickfix/double-conversion
  mkdir -p test
  mkdir -p spec
  
  cp quickfix/LICENSE .
  
  cp quickfix/src/ruby/quickfix*.rb lib
  cp quickfix/src/C++/*.h ext/quickfix
  cp quickfix/src/C++/*.hpp ext/quickfix
  cp quickfix/src/C++/*.cpp ext/quickfix
  cp quickfix/src/C++/double-conversion/* ext/quickfix/double-conversion
  cp quickfix/src/ruby/QuickfixRuby.cpp ext/quickfix
  cp quickfix/src/ruby/QuickfixRuby.h ext/quickfix
  cp quickfix/src/ruby/test/*TestCase.rb test
  
  cp quickfix/spec/FIX*.xml spec
  
  touch ext/quickfix/config.h
  touch ext/quickfix/config_windows.h
  rm -f ext/quickfix/stdafx.*
}


cleanup(){
  rm -rf quickfix
  rm -rf lib
  rm -rf ext/quickfix/*.h
  rm -rf ext/quickfix/*.hpp
  rm -rf ext/quickfix/*.cpp
  rm -rf test
  rm -rf spec
}

cleanup
install_coreutils
build_quickfix_source
copy_source_files
rm -rf quickfix
echo "Done...!"
