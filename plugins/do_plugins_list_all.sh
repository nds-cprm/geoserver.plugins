#! /usr/bin/bash

version="2.19.0"
mkdir -p ${version}
cd ${version}
rm index.html

urls="https://sourceforge.net/projects/geoserver/files/GeoServer/${version}/extensions/"

wget -qnv ${urls}

cat index.html | \
grep 'net.sf.files' | \
sed -e "s/}, /},\n/g;s/    net.sf.files = {//" | \
sed -e 's/, "/,\n"/g' | \
grep -e "download_url" -e "md5" | \
sed -e 'N;s/\n/ /; s/"//g; s/download_url://; s/md5://; s/,//g; s/^/N /; s/  / /g; ' | \
sed -e 's/\([^ ]\+\) \([^ ]\+\) \([^ ]\+\)/ \1 \2 \2 \3/; ' | \
sed -e "s*${urls}geoserver**; s*-${version}-**; s*-plugin.zip/download**"

exit 0

