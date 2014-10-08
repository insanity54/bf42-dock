#!/bin/bash

# send heartbeat to the new master server (workaround for gamespy shutdown)
echo '109.71.69.254 master.gamespy.com' >> /etc/hosts

# start the server
cd /srv/bf1942
/srv/bf1942/start.sh
