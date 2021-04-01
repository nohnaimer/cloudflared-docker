FROM centos:latest

RUN dnf install bind-utils -yqq
RUN dnf update -yqq

# Setup cloudflared proxy-dns server
RUN dnf install https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.rpm -yqq

ENV TUNNEL_METRICS="0.0.0.0:49353" \
    TUNNEL_DNS_ADDRESS="0.0.0.0" \
    TUNNEL_DNS_PORT="53" \
    TUNNEL_DNS_UPSTREAM="https://1.1.1.1/dns-query,https://1.0.0.1/dns-query"

ENTRYPOINT [ "/usr/local/bin/cloudflared", "--no-autoupdate" ]
CMD [ "proxy-dns" ]

EXPOSE 53/udp 49353/tcp

HEALTHCHECK --interval=30s --timeout=20s --start-period=10s \
  CMD dig +short @127.0.0.1 -p $TUNNEL_DNS_PORT cloudflare.com A || exit 1

# Clean up
RUN dnf clean all