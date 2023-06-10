FROM debian:stable-slim

RUN mkdir -p /node/
WORKDIR /node/

ENV VERSION=24.0.1
ADD https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz ./bitcoin.tar.gz
COPY config.conf ./
RUN tar xvzf bitcoin.tar.gz --directory . && mv bitcoin-${VERSION} bitcoin
EXPOSE 8000
ENTRYPOINT ["/node/bitcoin/bin/bitcoind", "-conf=/node/config.conf", "-datadir=/node/datadir/"]
