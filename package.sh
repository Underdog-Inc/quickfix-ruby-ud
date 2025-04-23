#!/bin/bash

set -e

echo "Building docker images for target platforms..."
docker build -f platforms/aarch64-linux.Dockerfile -t rake-dock-aarch64-linux .
docker build -f platforms/x86_64-linux.Dockerfile -t rake-dock-x86_64-linux .

echo "Cleaning up previous builds..."
rake clobber
rake clean

echo "Building aarch64-linux..."
RCD_IMAGE=rake-dock-aarch64-linux rake gem:aarch64-linux --trace

echo "Building x86_64-linux..."
RCD_IMAGE=rake-dock-x86_64-linux rake gem:x86_64-linux --trace

echo "Cleaning up..."
rake clean

echo "Pushing gems..."
pushd pkg
for gem_file in *.gem; do
  gem push "$gem_file"
done
popd

echo "Done!"