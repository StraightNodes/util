#!/bin/bash
set -e

echo "Installing SystemCTL"

if ! command -v python3 >/dev/null 2>&1; then
    echo "Python3 isn't installed!"
    if [ -f /etc/debian_version ]; then
        DEBIAN_FRONTEND=noninteractive apt-get update
        DEBIAN_FRONTEND=noninteractive apt-get install -y python3 curl
    fi
fi

if [ ! -f /usr/bin/systemctl ]; then
    curl -sSL https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py -o /usr/bin/systemctl
    chmod +x /usr/bin/systemctl
else
    echo "systemctl is already installed!!!"
fi

if [ ! -f /usr/bin/journalctl ]; then
    curl -sSL https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/journalctl3.py -o /usr/bin/journalctl
    chmod +x /usr/bin/journalctl
else
    echo "journalctl is already installed!!!"
fi

clear
echo "Done! You can now use systemctl"

