FROM ubuntu:20.04

# NOTE: zimbu fails to compile when its directory is located in /
#       because IO.fullPath(IO.getdir()) returns NIL in Config.zu
WORKDIR /zimbu/zimbu

# NOTE: clang is required to build zimbu bin
RUN apt update -y && \
    apt install -y git make vim clang

# clone to the current dir
# NOTE: since official repo is no longer available, use github.com/bsed/zimbuw32 instead
RUN git clone https://github.com/bsed/zimbuw32 .

RUN make bootstrap

ENV PATH $PATH:/zimbu/zimbu
