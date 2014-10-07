FROM ubuntu:14.04

MAINTAINER Chris Grimmett <chris@grimtech.net>

# add server assets to container
ADD ./assets /srv/assets

# satisfy some deps
RUN apt-get update && apt-get -y install wget expect

# setup battlefield server package
#   * downloads needed bf server files
#   * extracts 1.6 files
#   * patches to 1.61
RUN bash -x /srv/assets/setup.sh

# open ports for BF server
EXPOSE 14567

# run battlefield server
# RUN bash -x /srv/assets/bf1942/start.sh #dont do this here
