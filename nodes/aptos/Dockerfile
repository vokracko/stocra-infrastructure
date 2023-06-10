FROM debian:bullseye AS debian-base
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

FROM rust:1.63.0-buster@sha256:0110d1b4193029735f1db1c0ed661676ed4b6f705b11b1ebe95c655b52e6906f AS rust-base
WORKDIR /aptos
RUN apt-get update && apt-get install -y cmake curl clang git pkg-config libssl-dev libpq-dev lld

### Build Rust code ###
#FROM rust-base as builder
#ENV VERSION=aptos-node-v1.3.3
#RUN git clone https://github.com/aptos-labs/aptos-core.git /aptos && cd /aptos && git checkout ${VERSION}
#WORKDIR /aptos
#RUN cargo build --profile=release -p aptos-node

### Download prebuilt binaries for releases that are not published in the repo ###
FROM rust-base as downloader
ENV VERSION=aptos-node-v1.3.3
RUN wget https://github.com/aptos-labs/aptos-core/releases/download/${VERSION}/aptos-node-ubuntu-20-04.tgz -O aptos-node.tgz
RUN tar xvzf aptos-node.tgz

FROM debian-base AS validator

RUN apt-get update && apt-get install -y \
    libssl1.1 \
    ca-certificates \
    # Needed to run debugging tools like perf
    linux-perf \
    sudo \
    procps \
    gdb \
    curl \
    # postgres client lib required for indexer
    libpq-dev \
    && apt-get clean && rm -r /var/lib/apt/lists/*

RUN mkdir -p /opt/aptos/etc
RUN mkdir -p /node
#COPY --from=builder /aptos/target/release/aptos-node /usr/local/bin/
COPY --from=downloader /aptos/aptos-node /usr/local/bin/
ADD config.yaml genesis.blob waypoint.txt /node/

ENV RUST_BACKTRACE 1
ENV RUST_LOG_FORMAT=json
