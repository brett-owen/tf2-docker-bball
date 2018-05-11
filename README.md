tf2-docker-bball
================

**tf2-docker-bball** is a build script for a Team Fortress 2 docker container, the container is pre-configured with [Metamod:Source](https://www.sourcemm.net/) and [SourceMod](https://www.sourcemod.net/) by default, but the entire tf/ directory of the server can be overridden using attached volumes. This is useful for adding maps and configs as well.

This container also contains LogsTF and SupStats2 plugins by F2, demos.tf plugins, and my own kothbball plugin as well as some bball maps.

Usage
-----
```bash
docker pull brettowen/tf2-docker-bball
docker run -it -d --network=host -v /path/to/tf:/mnt -e MAP=set_a_map -e SV_HOSTNAME="YourServerNameHere" -e SV_MAXPLAYERS=12 -e RCON_PASSWORD="ChangeThis" brettowen/tf2-docker-bball
```
The environment variables you can set are:
- MAP
- SV_HOSTNAME
- SV_MAXPLAYERS
- RCON_PASSWORD
- SV_PORT
- LOGS_APIKEY
- DEMOS_APIKEY

By linking a folder containing a structure like the tf folder in Team Fortress 2 (maps/cfg/addons) you can override the defaults for the server and add maps.

For example if you link a folder using -v /path/to/your/folder:/mnt with a directory structure like the following it will override the defaults in the docker container.
```
/path/to/tf
│   maplist.txt  
│
└───cfg
│   │   server.cfg
│   │   ...
│   │
│   └───sourcemod
│       │   sourcemod.cfg
│   
└───maps
    │   your_map_here.bsp
    │   another_map_here.bsp
    |   ...
```

Installation
------------
Personally, I use this with a vps-hosted docker provider, like [DigitalOcean](https://www.digitalocean.com/) or [Vultr](https://www.vultr.com/), but it works fine on a local machine if you have docker installed. On a vps or a local machine you likely need to forward/unblock ports though. The container uses approx 600-800mb of ram when running, depending on load. Works great on a $5/mo vultr vps.

In the `install` folder I've provided an installation script for linux machines.

**Usage = Replace the variables in the included install script with your own information and run the script on the machine you wish to install**
```bash
#!/bin/bash

SVNAME="ServerName"
RCON="ServerRcon"
MAP="ctf_ballin_skyfall"
MAXPLAYERS="10"
SVPORT="27015"
LOGSAPI=7
DYNDNS=""
DOCKERVOL="/root/tf"
DOCKERIMG="brettowen/tf2-docker-bball"
CNAME="bball"

mkdir /root/tf /root/tf/maps /root/tf/addons /root/tf/cfg

docker stop $CNAME
docker rm $CNAME
docker rmi $DOCKERIMG

docker create \
       --name=$CNAME \
       --network=host \
       --restart=unless-stopped \
       -v $DOCKERVOL:/mnt \
       -e MAP=$MAP \
       -e SV_HOSTNAME="$SVNAME" \
       -e SV_MAXPLAYERS=$MAXPLAYERS \
       -e RCON_PASSWORD="$RCON" \
       -e SV_PORT=$SVPORT \
       -e LOGS_APIKEY=$LOGSAPI \
       $DOCKERIMG

curl -s $DYNDNS
docker start $CNAME
systemctl enable docker
```
You can also pipe the script to a remote server via ssh `ssh root@ip "bash -s" < install.sh`
DOCKERVOL is a path to a `tf` folder containing maps, configs, and other addons located on the server.
DYNDNS is a dynamic dns update link for the server, ignore it if you don't have one.
