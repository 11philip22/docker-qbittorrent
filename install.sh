#! /bin/sh

# install deps
echo -e "\e[32m[INFO] Install depandancies\e[0m"
apk add --no-cache \
    boost-system \
    boost-thread \
    ca-certificates \
    dumb-init \
    libressl \
    qt5-qtbase

echo -e "\e[32m[INFO] Install build depandancies\e[0m"
apk add --no-cache -t .build-deps \
    boost-dev \
    curl \
    cmake \
    g++ \
    make \
    libressl-dev \
    git \
    qt5-qttools-dev \
    qt5-qtsvg-dev \
    autoconf \
    libtool \
    automake
    
# install libtorrent
echo -e "\e[32m[INFO] Install libtorrent\e[0m"
# mkdir -p /tmp/libtorrent-rasterbar/build
# libtorrent_url=$(curl -sSL https://api.github.com/repos/arvidn/libtorrent/releases/latest | \
#     grep browser_download_url  | head -2 | tail -1 | cut -d '"' -f 4)
# curl -sSL "${libtorrent_url}" | tar xzC /tmp/libtorrent-rasterbar
# cd /tmp/libtorrent-rasterbar/build || exit 1
# cmake ../libtorrent-rasterbar* && make install
git clone https://github.com/arvidn/libtorrent.git /tmp/libtorrent
cd /tmp/libtorrent || exit 1
git checkout RC_1_2
./autotool.sh
./configure --disable-debug --enable-encryption
make clean && make -j"$(nproc)"
make install

# install qbittorrent
echo -e "\e[32m[INFO] Install qbittorrent\e[0m"
git clone https://github.com/qbittorrent/qBittorrent.git /tmp/qbittorrent
cd /tmp/qbittorrent || exit 1
# latesttag=$(git describe --tags "$(git rev-list --tags --max-count=1)")
# git checkout "${latesttag}"
# git checkout v4_1_x
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./configure --disable-gui --disable-stacktrace
make -j"$(nproc)"
make install

# cleanup
echo -e "\e[32m[INFO] Cleanup\e[0m"
apk del --purge .build-deps
rm -rf /tmp/* 

# user stuff
echo -e "\e[32m[INFO] Creating user \e[0m"
adduser -S -D -u 1000 -g 1000 -s /sbin/nologin user
mkdir -p /home/qbittorrent/.config/qBittorrent
mkdir -p /home/qbittorrent/.local/share/data/qBittorrent
ln -s /home/qbittorrent/.config/qBittorrent /config
ln -s /home/qbittorrent/.local/share/data/qBittorrent /torrents