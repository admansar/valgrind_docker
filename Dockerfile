FROM debian:12

RUN apt update

RUN apt install -y vim valgrind gdb make clang g++

USER $USER

WORKDIR /home/$USER

CMD tail -f
