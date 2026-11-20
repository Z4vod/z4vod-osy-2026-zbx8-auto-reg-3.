# Zabbix Agent 2 – automatická registrace

## Cíl projektu

Cílem projektu bylo vytvořit virtuální stroj s operačním systémem Debian 13 pomocí nástroje Vagrant, nainstalovat Zabbix Agent 2 ve verzi 8.0 LTS a nastavit jeho automatickou registraci na server `enceladus.pfsense.cz`.

Instalace a konfigurace probíhá automaticky pomocí provisioning skriptů.

## Použité technologie

- Debian 13
- Vagrant
- VirtualBox
- Zabbix Agent 2 – verze 8.0 LTS
- Oficiální repozitář Zabbix pro Debian 13

## Soubory projektu

- `Vagrantfile` – konfigurace virtuálního stroje a spuštění provisioning skriptů.
- `install-zabbix.sh` – instalace Zabbix Agent 2 z oficiálního repozitáře Zabbix.
- `configure-zabbix.sh` – nastavení konfigurace agenta a spuštění služby.
- `Images/` – snímky obrazovky dokazující registraci a funkční monitoring.

## Konfigurace Zabbix Agenta

V konfiguračním souboru `/etc/zabbix/zabbix_agent2.conf` jsou nastaveny následující hodnoty:

| Parametr | Hodnota |
|---|---|
| Hostname | `debian-zavodancikm-a7f39c` |
| Server | `enceladus.pfsense.cz` |
| ServerActive | `enceladus.pfsense.cz` |
| HostMetadata | `SPOS` |

Jedinečný název hosta zůstává zachován i po restartu virtuálního stroje a opakovaném spuštění provisioningu.

## Spuštění projektu

1. Otevřeme terminál v kořenovém adresáři projektu.
2. Spustíme virtuální stroj příkazem:

   ```bash
   vagrant up
   ```

3. Vagrant automaticky vytvoří virtuální stroj s Debianem 13 a spustí instalační a konfigurační skripty.
4. Do virtuálního stroje se přihlásíme příkazem:

   ```bash
   vagrant ssh
   ```

Pokud chceme provisioning spustit znovu, použijeme:

```bash
vagrant provision
```

## Ověření funkčnosti

Po instalaci lze ověřit verzi agenta příkazem:

```bash
zabbix_agent2 -V
```

Stav služby ověříme příkazem:

```bash
sudo systemctl status zabbix-agent2
```

Správnou funkčnost agenta ověříme příkazem:

```bash
sudo zabbix_agent2 -t agent.ping
```

Výsledkem je hodnota:

```text
agent.ping [s|1]
```

Dále byla ověřena automatická registrace hosta na serveru `enceladus.pfsense.cz`. Host s názvem `debian-zavodancikm-a7f39c` se na serveru objevil.

## Výsledek

Virtuální stroj s Debianem 13 byl úspěšně vytvořen. Zabbix Agent 2 verze 8.0 LTS byl automaticky nainstalován a nakonfigurován pomocí Vagrantu.

Host `debian-zavodancikm-a7f39c` byl automaticky zaregistrován na Zabbix serveru učitele.

Důkazy o registraci a monitorování jsou uloženy ve složce `Images/`.

