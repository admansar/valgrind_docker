#!/bin/bash


function 42-wizzard-docker()
{
	docker_destination="/goinfre/$USER/docker"
	if [ ! -d "/Applications/Docker.app" ] && [ ! -d "~/Applications/Docker.app" ]; then
		printf "$YELLOW Docker is not installed $RESET \n"
		printf "Please install docker trough $BLUE Managed Software Center $RESET then hit enter to continue \n"
		open -a "Managed Software Center"
		exit 1
	fi
	pkill Docker 2> /dev/null
	unlink ~/Library/Containers/com.docker.docker > /dev/null 2>&1
	unlink ~/Library/Containers/com.docker.helper > /dev/null 2>&1
	unlink ~/.docker > /dev/null 2>&1
	unlink ~/Library/Containers/com.docker.docker > /dev/null 2>&1
	unlink ~/Library/Containers/com.docker.helper > /dev/null 2>&1
	unlink ~/.docker > /dev/null 2>&1
	/bin/rm -rf ~/Library/Containers/com.docker.{docker,helper} ~/.docker > /dev/null 2>&1
	mkdir -p "$docker_destination"/{com.docker.{docker,helper},.docker} > /dev/null 2>&1
	ln -sf "$docker_destination"/com.docker.docker ~/Library/Containers/com.docker.docker > /dev/null 2>&1
	ln -sf "$docker_destination"/com.docker.helper ~/Library/Containers/com.docker.helper > /dev/null 2>&1
	ln -sf "$docker_destination"/.docker ~/.docker > /dev/null 2>&1
	printf "Docker installed in $GREEN $docker_destination $RESET \n"
	open -g -a Docker
}


if ! command -v docker &> /dev/null; then
	echo "Docker is not installed. Please install Docker and try again."
	if [ $(uname) -eq "Darwin" ] 
	then
		42-wizzard-docker 
	fi
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

