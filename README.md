# Infrastructure
A set of templates and scripts to run whole stocra infrastructure.

## Disclaimer
This is the most difficult part of stocra to make generic as it is heavily customized to suite my needs.
Be ready to spend some time understanding how it works and how to customize it for your needs.

## External services
- [BetterUptime](https://betteruptime.com/team/42739/monitors) for status page using `/status` sidecar endpoint
- [GlitchTip](https://glitchtip.com/) for error tracking, see [./glitchtip](./glitchtip)
- [Netdata](https://www.netdata.cloud/) for server monitoring
- [Letsencrypt](https://letsencrypt.org/) for SSL certificates, see below

## Servers
That I used to run stocra infrastructure, all from [hetzner](https://www.hetzner.com/):
- Bitcoin: Intel Core i7-8700, HDD2x SSD M.2 NVMe 1 TB, RAM4x RAM 16384 MB DDR4
- Ethereum: AX101
- Litecoin + Dogecoin: AX41-NVMe
- Aptos + Cardano: AX101
	
## Configuration
1. Include [ssh.config](ssh.config) into your `~/.ssh/config`
2. Replace `stocra.tld` everywhere with your domain
3. Decide which nodes you want to run and define:
  - [ansible/inventory](ansible/inventory)
  - [ssh.config](ssh.config)
  - [ansible/playbooks/deploy.yaml](ansible/playbooks/deploy.yaml)
4. Request certificates (see below)

### Refreshing certificates
```bash
docker run -it --rm --name certbot -v $(pwd)/letsencrypt:/etc/letsencrypt certbot/certbot certonly -d stocra.tld -d "*.stocra.tld" --agree-tos --preferred-challenges=dns --manual
sudo chown -R $USER:$USER ./letsencrypt
cd ansible ; ansible-playbook playbooks/copy_certificates.yaml
```
### Adding new server
1. Create new SSH key with `ssh-keygen`, copy your public key to the server
2. Add server into `inventory` and `ssh.config`
3. Define what blockchains it will run `ansible/playbooks/deploy.yaml`
4. [optional] Extend `sidecar_urls` in `ansible/roles/<blockchain>/vars/main.yaml` for each blockchain that will run on the server (if its not the first instance)
5. Set-up DNS records for each blockchain: `A <blockchain_name>-N.stocra.tld <ip>`
7. [optional] Enable password-less sudo if user not root (but everything is configured for root)
8. `ansible-playbook playbooks/setup.yaml --limit <server1>`
9. `ansible-playbook playbooks/deploy.yaml --limit <server1> --extra-vars "stop_sidecar=yes"` # to prevent errors while syncing
12. Wait for nodes to sync
14. `ansible-playbook playbooks/deploy.yaml --limit <server1>`

### Adding new blockchain
1. Define new blockchain in [nodes](nodes), [traefik](./traefik/dynamic.yaml), [ansible/roles](ansible/roles), [ansible/deploy.yaml](ansible/playbooks/deploy.yaml) 
4. Set-up DNS records: `A <blockchain_name>-N.stocra.tld <ip>`
5. `ansible-playbook playbooks/deploy.yaml --extra-vars "stop_sidecar=yes"`
6. Wait for nodes to sync 
7. `ansible-playbook playbooks/deploy.yaml`
