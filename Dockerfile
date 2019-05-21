FROM ubuntu:16.04

WORKDIR /app

# copy the contents of agent working directory on host to workdir in container
COPY . ./

RUN apt-get update && \
      apt-get -y install sudo

#RUN sudo apt-get update
RUN sudo apt-get install build-essential -y
RUN gcc -v
RUN sudo apt-get install --no-upgrade libboost-all-dev -y
RUN g++ -std=c++11 -I/usr/include/boost/asio -I/usr/include/boost -o binary.out main.cpp connection.cpp connection_manager.cpp mime_types.cpp reply.cpp request_handler.cpp request_parser.cpp server.cpp -lboost_system -lboost_thread -lpthread

COPY /home/vsts/work/1/a/. ./

RUN unzip ./*.zip
RUN ./a.out
