FROM debian:stable-slim AS base

FROM base AS builder
RUN apt-get update && apt-get install -y cmake curl clang git pkg-config libssl-dev libpq-dev
ENV VERSION=1.29.0
RUN git clone https://github.com/near/nearcore && cd nearcore && git fetch origin --tags && git checkout tags/${VERISON} && make release

FROM builder as node
RUN mkdir -p /node/
WORKDIR /node/
COPY --from=builder /nearcore/target/release/neard /node/neard

EXPOSE 8000
ENTRYPOINT ["/node/neard", "--home",  "/node/datadir", "run"]
