FROM debian:stable-slim

RUN mkdir -p /node/
WORKDIR /node/

ENV VERSION=3.2.0
ADD https://github.com/AntelopeIO/leap/releases/download/v${VERSION}/leap-${VERSION}-ubuntu20.04-x86_64.deb leap.deb
RUN apt update && apt install -y ./leap.deb
COPY config.ini genesis.json ./

ENTRYPOINT ["nodeos", "--config", "/node/config.ini", "--data-dir", "/node/datadir/", "--genesis-json", "genesis.json"]
