FROM ubuntu:18.04

COPY ./cs143 /home/

RUN ls /home/assignments	

RUN apt-get update
RUN apt-get install -y \
	gcc-multilib \
	flex-old \
	bison \
	nano \
	g++ \
	make

RUN cd /home/bin && \
	./../bin/.i686/coolc ../examples/arith.cl -o arith.s