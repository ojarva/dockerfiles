FROM ubuntu:14.04

ENV GOSU_VERSION 1.7
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

RUN wget -O /opt/utserver.tar.gz http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0 && cd /opt && tar -xvzf utserver.tar.gz && rm utserver.tar.gz


COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN apt-get install -y libssl1.0.0 && \
 addgroup --gid 9999 app && \
 alias adduser='useradd' && \
 adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app && \
 usermod -L app && \
 mkdir /data && \
 mkdir /data/incomplete && \
 mkdir /data/completed && \
 mkdir /data/torrents && \
 chown -R app:app /data && \
 mv /opt/utorrent-server-alpha-v3_3 /opt/utorrent-server && \
 chown -R app:app /opt/ && \
 chmod 755 /usr/local/bin/docker-entrypoint.sh && \
 mkdir /opt/utorrent-server/settings

COPY settings.dat /opt/utorrent-server/settings.dat.bak


EXPOSE 6881
EXPOSE 8080

WORKDIR /opt/utorrent-server

VOLUME ["/data", "/opt/utorrent-server/settings"]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["/opt/utorrent-server/utserver -settingspath", "/opt/utorrent-server/settings"]
