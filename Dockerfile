FROM alpine:3.10

COPY qBittorrent.conf /default/qBittorrent.conf
COPY qBittorrent.conf /config/qBittorrent.conf
COPY install.sh /install.sh

RUN chmod +x /install.sh; \
    sh /install.sh

CMD ["qbittorrent-nox"]

VOLUME ["/config", "/torrents", "/downloads"]
EXPOSE 8080