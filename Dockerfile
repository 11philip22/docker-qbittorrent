FROM philipwold/alpine-s6

ENV HOME="/config" \
    XDG_CONFIG_HOME="/config" \
    XDG_DATA_HOME="/config"

COPY root/usr/local/bin/install.sh /usr/local/bin/install.sh

RUN chmod +x /usr/local/bin/install.sh; \
    /usr/local/bin/install.sh

COPY root/ /

RUN rm /usr/local/bin/install.sh

VOLUME ["/config", "/torrents"]
EXPOSE 8080 6881