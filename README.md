### Run via Docker CLI client

To run the utorrent container you can execute:

```bash
docker run                                            \
    --name cloudflared                                \
    -p 53:53                                          \
    -p 49353:49353                                    \
    nohnaimer/cloudflared:<tag>
```

### Settings persistence

#### Change address and upstream
```bash
docker run                                              \
    --name cloudflared                                  \
    -e TUNNEL_DNS_ADDRESS=127.0.0.1                     \
    -e TUNNEL_DNS_UPSTREAM=https://dns.google/dns-query \
    -p 53:53                                            \
    -p 49353:49353                                      \
    nohnaimer/cloudflared:<tag>
```

## Run via Docker Compose

Create your Docker Compose file (docker-compose.yml) using the following YAML snippet:

```yaml
version: '3.7'
services:
  cloudflared:
    image: nohnaimer/cloudflared:<tag>
    ports:
      - 53:53
      - 49353:49353
    environment:
      TUNNEL_DNS_ADDRESS: 127.0.0.1
      TUNNEL_DNS_PORT: 53
    restart: always
```

## Changes
* 2021-04-01 Init commit. Cloudflared latest version.