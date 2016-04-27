#!/bin/sh

mkdir -p /data/completed
mkdir -p /data/incomplete
mkdir -p /data/torrents

chown app:app /data -R
chown app:app /opt -R

# Interestingly enough webui.zip must be in settings directory.
if [ ! -f /opt/utorrent-server/settings/webui.zip ]; then
  cp /opt/utorrent-server/webui.zip /opt/utorrent-server/settings/webui.zip
fi

if [ ! -f /opt/utorrent-server/settings/settings.dat ]; then
  echo "Replacing settings.dat with default settings"
  cp /opt/utorrent-server/settings.dat.bak /opt/utorrent-server/settings/settings.dat
  chown app:app /opt/utorrent-server/settings -R
fi

gosu app $@
