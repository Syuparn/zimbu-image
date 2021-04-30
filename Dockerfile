FROM ubuntu:20.04 AS builder

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

# required to run zimbu bin
FROM gcc:10

WORKDIR /zimbu/zimbu

COPY --from=builder /zimbu/zimbu .

ENV PATH $PATH:/zimbu/zimbu
