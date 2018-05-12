#!/bin/bash

echo "hostname "${SV_HOSTNAME} >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg
echo "rcon_password "${RCON_PASSWORD} >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg

echo 'tv_enable 1' >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg
echo 'tv_name "The Eye of Pye"' >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg
echo 'tv_title "The Eye of Pye"' >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg
echo 'tv_maxrate 0' >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg
echo 'tv_relayvoice 1' >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg
echo 'tv_snapshotrate 66' >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg
echo 'tv_transmitall 1' >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg
echo 'tv_maxclients 0' >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg
echo 'tv_autorecord 0' >> /home/steam/steamcmd/tf2/tf/cfg/autoexec.cfg

while true; do
cp -asf /mnt/* /home/steam/steamcmd/tf2/tf
rm -f /home/steam/steamcmd/tf2/tf/match-*
/home/steam/steamcmd/tf2/srcds_run -game tf -autoupdate -console -usercon -steam_dir /home/steam/steamcmd -steamcmd_script /home/steam/steamcmd/tf2serv.txt -port ${SV_PORT} +log on +sv_pure 2 +ip "0.0.0.0" +map ${MAP} +maxplayers ${SV_MAXPLAYERS} +logstf_apikey ${LOGS_APIKEY} +sm_demostf_apikey ${DEMOS_APIKEY}
done
