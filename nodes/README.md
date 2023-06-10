# ENV file:
```
ENVIRONMENT=bitcoin-1
NODE_BLOCKCHAIN=bitcoin
NODE_URL=http://bitcoin-node-1:8000
NODE_TOKEN='TOKEN'
REDIS_HOST=infrastructure-redis-1
SIDECAR_TOKEN='sidecar-token'
SIDECAR_URLS='[]'
```

# RPC auth for bitcoin based nodes
- https://jlopp.github.io/bitcoin-core-rpc-auth-generator/
- https://www.blitter.se/utils/basic-authentication-header-generator/

# Forward ports from server to localhost
```bash
ssh -NL 9000:ethereum-node-1:8000 stocra-hetzner-ethereum
ssh -NL 9000:bitcoin-node-1:8000 stocra-hetzner-bitcoin
ssh -NL 9000:aptos-node-1:8000 stocra-hetzner-aptos-cardano
ssh -NL 9000:cardano-node-1:8000 stocra-hetzner-aptos-cardano
```
