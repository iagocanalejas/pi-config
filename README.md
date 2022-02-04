# Pi Config

**A Raspberry Pi Configuration for Internet connectivity**: It currently needs two raspberrys to configure `pihole` and `pinas`.

## Features

- **Pi-hole**: Installs the Pi-hole Docker configuration so you can use Pi-hole for network-wide ad-blocking and local DNS. Make sure to update your network router config to direct all DNS queries through your Raspberry Pi if you want to use Pi-hole effectively!
- **Home Assistant**: Installs the Home Assistant Docker configuration to work as a home automation manager.
- **TradeBot**: Test trading bot docker container fetched from [github](https://github.com/CyberPunkMetalHead/gateio-crypto-trading-bot-binance-announcements-new-coins).

### Media

- **MergerFs**: Combine mounted drives to improve navigation.
- **Samba**: Expose drives as shares to the lcoal network.
- **Jellyfin**: Organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices.

## Setup

  1. Make copies of the following files and customize them to your liking:
     - `group_vars/all/secrets.example.yml` to `secrets.yml` (replace configurations).
  2. Change `hosts.ini` IPs to match the ones the raspberries pick.
  3. Run the script: `ansible-playbook main.yml`.
  4. Run the reboot script: `ansible-playbook reboot.yml`.

## Updating

To upgrade the raspberries and docker containers in them run `ansible-playbook main.yml --tags update`.

## Backups
#TODO
