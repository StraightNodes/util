#!/bin/bash
set -e

echo "Installing SystemCTL"

if ! command -v python3 >/dev/null 2>&1; then
    echo "Python3 isn't installed!"
    if [ -f /etc/debian_version ]; then
        apt-get update
        apt-get install -y python3 curl
    fi
fi

# Download systemctl.py directly from the repository
if [ ! -f /usr/bin/systemctl ]; then
    curl -sSL https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py -o /usr/bin/systemctl
    chmod +x /usr/bin/systemctl
else
    echo "systemctl is already installed!!!"
fi

clear
echo "Done! You can now use systemctl"
