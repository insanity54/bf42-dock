#!/bin/bash

serverFile='/tmp/bf1942_lnxded-1.6-rc2.run'
serverPatchFile='/tmp/bf1942_lnxded-1.612-patched.tar.gz'

# download the server
if [[ ! -e $serverFile ]]; then
    echo 'Downloading BF1942 server'
    wget -q 'https://dweb.link/ipfs/bafybeibdg5vpsldsfuvemdk4wfi6es46noxnbg6pjxjsmb27tr6g74wmfq?filename=bf1942_lnxded-1.6-rc2.run' -O $serverFile
fi

# download 1.612 patch
if [[ ! -e $serverPatchFile ]]; then
    echo 'Downloading Team SIMPLE BF1942 Server 1.612 patched'
    wget -q 'https://dweb.link/ipfs/bafybeif2gncdf2ewmqahd6jhn5hld2v65ck3pyzff4yqfzdtom4vjay4tu?filename=bf1942_lnxded-1.612-patched.tar.gz' -O $serverPatchFile
fi

# copy downloaded files in tmp dir to current dir
cp $serverFile /tmp/
cp $serverPatchFile /tmp/

# verify downloaded files are valid
cd /tmp
cp /srv/assets/MD5SUMS .
md5sum -c MD5SUMS

if [[ $? -ne 0 ]]; then
    echo 'file integrity check failed'
    exit 1
else
    echo 'files are full of integrity'
fi

# extract server files
cp /srv/assets/extract
./extract


# verify files extracted as they should
if [[ $? -ne 0 ]] || [[ ! -e /srv/bf1942 ]]; then
    echo '1.6 server files did not extract correctly'
    exit 1
fi

# extract patch files
tar -xvzf bf1942_lnxded-1.612-patched.tar.gz -C /srv


# link
ln -s /srv/bf1942/bf1942_lnxded.static /srv/bf1942/bf1942_lnxded

exit 0
