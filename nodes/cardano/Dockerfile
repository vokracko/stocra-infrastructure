FROM debian:stable-slim AS base

RUN mkdir -p /node/
WORKDIR /node/
RUN apt-get update && apt-get install -y netbase

FROM base AS node
ENV VERSION=1.35.5
ADD https://update-cardano-mainnet.iohk.io/cardano-node-releases/cardano-node-${VERSION}-linux.tar.gz ./cardano.tar.gz
RUN tar xvzf cardano.tar.gz --directory ./
EXPOSE 8000
ENTRYPOINT [ \
    "/node/cardano-node", \
    "run", \
    "--topology=/node/configuration/cardano/mainnet-topology.json", \
    "--database-path=/node/datadir/", \
    "--config=/node/configuration/cardano/mainnet-config.json", \
    "--socket-path=/node/datadir/node.socket", \
    "--port=8000" \
]

FROM base AS dbsync
RUN apt-get install -y git postgresql
RUN mkdir -p /cardano-node/configuration/cardano/
COPY --from=node /node/configuration/cardano/ /node/cardano-node/configuration/cardano/
ENV VERSION=13.1.0.0
ADD pgpass cardano-db-sync ./
RUN chmod 0600 pgpass && chmod 777 cardano-db-sync
RUN git clone --depth 1 -b ${VERSION} https://github.com/input-output-hk/cardano-db-sync gitrepo
ENV PGPASSFILE=/node/pgpass
ENTRYPOINT [ \
    "/node/cardano-db-sync", \
    "--config=/node/gitrepo/config/mainnet-config.yaml", \
    "--schema-dir=/node/gitrepo/schema", \
    "--state-dir=/node/datadir/dbsync", \
    "--socket-path=/node/datadir/node/node.socket" \
]
