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
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./configure --disable-gui --disable-stacktrace
make -j"$(nproc)"
make install

# cleanup
echo -e "\e[32m[INFO] Cleanup\e[0m"
apk del --purge .build-deps
rm -rf /tmp/* 

# user stuff
echo -e "\e[32m[INFO] Creating user \e[0m"
mkdir -p /home/user/.config/qBittorrent
mkdir -p /home/user/.local/share/data/qBittorrent
ln -s /home/user/.config/qBittorrent /config
ln -s /home/user/.local/share/data/qBittorrent /torrents
echo -e "\e[32m[INFO] Fixing permissions \e[0m"
chown -R user:user /config
chown -R user:user /torrents
chown -R user:user /home/user/.config
chown -R user:user /home/user/.local