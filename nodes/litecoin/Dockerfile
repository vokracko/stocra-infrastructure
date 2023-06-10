FROM debian:stable-slim

RUN mkdir -p /node/
WORKDIR /node/

ENV VERSION=0.21.2.2
ADD https://download.litecoin.org/litecoin-${VERSION}/linux/litecoin-${VERSION}-x86_64-linux-gnu.tar.gz ./litecoin.tar.gz
COPY config.conf ./
RUN tar xvzf litecoin.tar.gz --directory . && mv litecoin-${VERSION} litecoin
EXPOSE 8000
ENTRYPOINT ["/node/litecoin/bin/litecoind", "-conf=/node/config.conf", "-datadir=/node/datadir/"]
