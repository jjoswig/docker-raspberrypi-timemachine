FROM alpine:latest
MAINTAINER Julian Joswig <julian.joswig@joswig-it.de>

# install samba and s6; create supporting directories
RUN apk add --no-cache avahi avahi-compat-libdns_sd avahi-tools dbus samba-common-tools s6 samba-server &&\
  mkdir /opt/timemachine &&\
  touch /etc/samba/lmhosts &&\
  rm /etc/samba/smb.conf &&\
  rm /etc/avahi/services/*.service

# copy in necessary supporting config files
COPY s6 /etc/s6
COPY entrypoint.sh /

VOLUME ["/var/lib/samba","/var/cache/samba","/run/samba"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["s6-svscan","/etc/s6"]
