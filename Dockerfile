FROM philipwold/alpine-s6

COPY root/ /

RUN chmod +x /usr/local/bin/install.sh; \
    /usr/local/bin/install.sh

VOLUME ["/config", "/torrents"]
EXPOSE 8080