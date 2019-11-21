#! /bin/sh

# user stuff
echo -e "\e[32m[INFO] Creating user \e[0m"
mkdir -p /home/user/.config/qBittorrent
mkdir -p /home/user/.local/share/data/qBittorrent
ln -s /home/user/.config/qBittorrent /config/qBittorrent
ln -s /home/user/.local/share/data/qBittorrent /torrents