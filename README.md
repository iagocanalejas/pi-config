```
scp scripts/network.sh pi@<rpi-current-ip>:/home/pi
ssh pi@<rpi-current-ip>
./network.sh -i <rpi-static-ip> -h <rpi-hostname> -d <rpi-dns>
```

# Pi Config

**A Raspberry Pi Configuration for Internet connectivity**

## Features

**Pi-hole**: Installs the Pi-hole Docker configuration so you can use Pi-hole for network-wide ad-blocking and local DNS. Make sure to update your network router config to direct all DNS queries through your Raspberry Pi if you want to use Pi-hole effectively!

**Home Assistant**: Installs the Home Assistant Docker configuration.

**Samba**: TODO.

## Recommended Pi and OS

You should use a Raspberry Pi 4 model B or better. The Pi 4 and later generations of Pi include a full gigabit network interface and enough I/O to reliably measure fast Internet connections.

Older Pis work, but have many limitations, like a slower CPU and sometimes very-slow NICs that limit the speed test capability to 100 Mbps or 300 Mbps on the Pi 3 model B+.

Other computers and VMs may run this configuration as well, but it is only regularly tested on a Raspberry Pi.

The configuration is tested against Raspberry Pi OS, both 64-bit and 32-bit, and runs great on that or a generic Debian installation.

It should also work with Ubuntu for Pi, or Arch Linux, but has not been tested on other operating systems.

## Setup

  1. Make copies of the following files and customize them to your liking:
     - `example.config.cfg` to `config.cfg` (replace configurations).
  2. Run the script: `autoconf.sh`

## Updating

To upgrade Pi-hole to the latest version, run the following commands:

```bash
cd ~/pi-hole # 
docker-compose pull             # pulls the latest images
docker-compose up -d --no-deps  # restarts containers with newer images
docker system prune --all       # deletes unused images
```

Upgrades for the other configurations are similar (go into the directory, and run the same `docker-compose` commands. Make sure to `cd` into the `config_dir` that you use in your `config.cfg` file.


## Backups

# TODO: Write Readme
# TODO: Configure network
# TODO: Change raspberry password

