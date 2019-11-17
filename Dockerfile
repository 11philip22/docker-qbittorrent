FROM philipwold/alpine-tini

COPY install.sh /install.sh
RUN chmod +x /install.sh; \
    sh /install.sh

COPY qBittorrent.conf /config/qBittorrent.conf

USER qbittorrent

CMD ["qbittorrent-nox"]

VOLUME ["/config", "/torrents", "/downloads"]
EXPOSE 8080