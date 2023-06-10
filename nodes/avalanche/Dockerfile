FROM debian:stable-slim

RUN mkdir -p /node/
WORKDIR /node/

ENV VERSION=1.9.2
ADD https://github.com/ava-labs/avalanchego/releases/download/v${VERSION}/avalanchego-linux-amd64-v${VERSION}.tar.gz avalanchego.tar.gz
RUN tar xvzf avalanchego.tar.gz
COPY configs ./configs
RUN ls
ENTRYPOINT ["/node/avalanchego-v1.9.2/avalanchego", "--config-file", "/node/configs/node.json", "--db-dir", "/node/datadir/", "--chain-config-dir", "/node/configs/chains/"]

# https://docs.avax.network/nodes/maintain/avalanchego-config-flags#--index-enabled-boolean
