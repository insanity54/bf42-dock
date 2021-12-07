#!/bin/bash

serverFile='/tmp/bf1942_lnxded-1.6-rc2.run'
patchFile='/tmp/bf1942-update-1.61.tar.gz'


# verify needed files are downloaded
# download the server if it's not already downloaded
if [[ ! -e $serverFile ]]; then
    echo 'downloading 1.6 server'
    wget 'https://dweb.link/ipfs/bafybeibdg5vpsldsfuvemdk4wfi6es46noxnbg6pjxjsmb27tr6g74wmfq?filename=bf1942_lnxded-1.6-rc2.run' -O $serverFile
fi

# download patch if not already downloaded
if [[ ! -e $patchFile ]]; then
    echo 'downloading 1.61b patch'
    wget 'https://dweb.link/ipfs/bafybeie7463ofgnn2dhcxwqd7zvkyrv24mn4suose55aahlm74oq7z3nw4?filename=bf1942-update-1.61.tar.gz' -O $patchFile
fi

# copy downloaded files in tmp dir to current dir
cp $serverFile /srv/assets
cp $patchFile /srv/assets

# verify downloaded files are valid
cd /srv/assets
md5sum -c MD5SUMS

if [[ $? -ne 0 ]]; then
    echo 'downloaded file integrity check failed'
    exit 1
else
    echo 'downloaded files are full of integrity'
fi

# extract 1.6 files
chmod +x /srv/assets/bf1942_lnxded-1.6-rc2.run
./extract

# verify files extracted as they should
if [[ $? -ne 0 ]] || [[ ! -e /srv/bf1942 ]]; then
    echo '1.6 server files did not extract correctly'
    exit 1
fi

# patch to 1.61
tar -xvf ./bf1942-update-1.61.tar.gz -C /srv

# create a link to the start script
cp /srv/assets/start.sh /srv/start.sh


exit 0
