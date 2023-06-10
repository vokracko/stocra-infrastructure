FROM debian:stable-slim

RUN mkdir -p /node/
WORKDIR /node/

ENV VERSION=1.14.6
ADD https://github.com/dogecoin/dogecoin/releases/download/v${VERSION}/dogecoin-${VERSION}-x86_64-linux-gnu.tar.gz ./dogecoin.tar.gz
COPY config.conf ./
RUN tar xvzf dogecoin.tar.gz --directory . && mv dogecoin-${VERSION} dogecoin
EXPOSE 8000
ENTRYPOINT ["/node/dogecoin/bin/dogecoind", "-conf=/node/config.conf", "-datadir=/node/datadir/"]
