FROM debian:stable-slim

RUN mkdir -p /node/
WORKDIR /node/

ENV VERSION=1.11.6-ea9e62ca
ADD https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-${VERSION}.tar.gz ./geth.tar.gz
COPY config.toml ./
RUN tar xvzf geth.tar.gz --directory . && mv geth-linux-amd64-${VERSION} ethereum
EXPOSE 8000
ENTRYPOINT ["/node/ethereum/geth", "--config=/node/config.toml", "--datadir=/node/datadir/", "--datadir.ancient=/node/datadir-ancient/"]
