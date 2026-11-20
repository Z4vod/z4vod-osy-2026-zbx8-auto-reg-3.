
#!/bin/bash
set -e

CONFIG="/etc/zabbix/zabbix_agent2.conf"

set_config() {
    KEY="$1"
    VALUE="$2"

    # Remove all existing active and commented definitions
    sed -i -E "/^[[:space:]#]*${KEY}=/d" "$CONFIG"

    # Add exactly one definition
    echo "${KEY}=${VALUE}" >> "$CONFIG"
}
set_config "Hostname" "debian-zavodancikm-a7f39c"
set_config "Server" "enceladus.pfsense.cz"
set_config "ServerActive" "enceladus.pfsense.cz"
set_config "HostMetadata" "SPOS"

systemctl enable zabbix-agent2
systemctl restart zabbix-agent2

echo "Zabbix Agent 2 configuration:"
grep -E "^(Hostname|Server|ServerActive|HostMetadata)=" "$CONFIG"

echo "Service status:"
systemctl status zabbix-agent2 --no-pager
