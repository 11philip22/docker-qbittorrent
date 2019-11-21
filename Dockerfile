FROM philipwold/alpine-s6

COPY root/usr/local/bin/install.sh /usr/local/bin/install.sh

RUN chmod +x /usr/local/bin/install.sh; \
    /usr/local/bin/install.sh

COPY root/ /

RUN chmod +x /usr/local/bin/setup.sh; \
    /usr/local/bin/setup.sh

VOLUME ["/config", "/torrents"]
EXPOSE 8080