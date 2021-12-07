FROM ubuntu:focal

MAINTAINER Chris Grimmett <chris@grimtech.net>

# add server assets to container
ADD ./assets /srv/assets

# satisfy setup script and bf1942 dependencies
RUN \
  dpkg --add-architecture i386 && \
  apt-get -y update && \
  apt-get -y install expect wget libc6-i386 libc6-dev-i386 libncurses5:i386

# setup battlefield server package
RUN bash -x /srv/assets/setup.sh


EXPOSE 14567/udp 22000/udp 23000/udp

# set default command for running this container (run bf server)
CMD /srv/assets/start.sh
