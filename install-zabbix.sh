
#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y wget

cd /tmp

wget -O zabbix-release.deb \
  https://repo.zabbix.com/zabbix/8.0/release/debian/pool/main/z/zabbix-release/zabbix-release_latest+debian13_all.deb

dpkg -i zabbix-release.deb

apt-get update

apt-get install -y zabbix-agent2

echo "Installed Zabbix Agent 2 version:"
zabbix_agent2 -V | head -n 1
