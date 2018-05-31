FROM binhex/arch-openvpn:2018040901
MAINTAINER dan040790
ENV NZBGET_VERSION=19.1-1
# additional files
##################

# add supervisor conf file for app
ADD build/*.conf /etc/supervisor/conf.d/

# add bash scripts to install app
ADD build/root/*.sh /root/

# add run bash scripts
ADD run/root/*.sh /root/

# add run bash scripts
ADD run/nobody/*.sh /home/nobody/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh /home/nobody/*.sh && \
	/bin/bash /root/install.sh

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /data to host defined data path (used to store data from app)
VOLUME /data

# expose port for http
EXPOSE 6789

# set permissions
#################

ENV STRICT_PORT_FORWARD=no

# run script to set uid, gid and permissions
CMD ["/bin/bash", "/root/init.sh"]
