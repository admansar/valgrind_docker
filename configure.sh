#!/bin/bash

if ! command -v docker &> /dev/null; then
  echo "Docker is not installed. Please install Docker and try again."
  exit 1
fi

workdir=${1:-$PWD}

if [ ! -d "$workdir" ]; then
  echo "Error: Directory '$workdir' does not exist."
  exit 1
fi

echo "Using working directory: $workdir"

docker build -t valgrind:42 .

docker run --rm -v "$workdir":/home/"$USER" -it valgrind:42 bash

