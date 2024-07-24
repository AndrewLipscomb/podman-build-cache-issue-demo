#!/bin/bash

set -e

# cd to script dir
cd "$(dirname "$0")"

# Clean up first
rm -f src/my_content
docker rmi -f test-cache-build:latest
podman rmi -f test-cache-build:latest

# Set the file content
echo "first round implementation" > src/my_content

# Build as docker
docker build -f ./build.dockerfile -t test-cache-build .

# Build as podman
podman build -f ./build.dockerfile -t test-cache-build .

# Check content
docker_val="$(docker run --rm test-cache-build:latest cat /my_content)"
podman_val="$(podman run --rm test-cache-build:latest cat /my_content)"

echo "#####"
echo ""
echo "AFTER FIRST BUILD"
echo "docker = $docker_val"
echo "podman = $podman_val"
echo ""
echo "#####"

# Set the file content again
echo "second round implementation" > src/my_content

# Build as docker
docker build -f ./build.dockerfile -t test-cache-build .

# Build as podman
podman build -f ./build.dockerfile -t test-cache-build .

# Check content
docker_val="$(docker run --rm test-cache-build:latest cat /my_content)"
podman_val="$(podman run --rm test-cache-build:latest cat /my_content)"

echo "#####"
echo ""
echo "AFTER SECOND BUILD"
echo "docker = $docker_val"
echo "podman = $podman_val"
echo ""
echo "#####"