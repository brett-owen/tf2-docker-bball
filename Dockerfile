FROM brettowen/tf2-docker-sm

MAINTAINER Brett Owen <brett@brettowen.ca>

WORKDIR /home/steam/steamcmd/tf2/tf
ADD ./install/tf /mnt/
RUN cp -af /mnt/* /home/steam/steamcmd/tf2/tf

ADD startserver.sh /home/steam/steamcmd/startserver.sh

ENV MAP="ctf_ballin_skyfall"
ENV SV_MAXPLAYERS=16
ENV SV_HOSTNAME="changeme"
ENV RCON_PASSWORD="changeme"
ENV SV_PORT=27015
ENV LOGS_APIKEY=0

EXPOSE 27015 27015/udp

ENTRYPOINT ["/home/steam/steamcmd/startserver.sh"]
