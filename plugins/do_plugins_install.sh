#! /usr/bin/bash

version="2.19.0"

destination="/opt/tomcat/webapps/geoserver/WEB-INF/lib/"

mkdir -p ${destination}

plugins="plugins.default"

plugins="${1:-$plugins}"

# Y app-schema https://sourceforge.net/projects/geoserver/files/GeoServer/2.19.0/extensions/geoserver-2.19.0-app-schema-plugin.zip/download f9c43bd06ae07e50bf8c8452e6037186

while read install plugin url md5 ; do

	if  [ "${install}" = "Y" ]
	then

		echo "installing ${version}/${plugin}, from ${url}, with md5 ${md5}"

		mkdir -p ${plugin}

		cd ${plugin}

		wget -qnv ${url}

		echo "${md5} download" | md5sum -c || echo "FAIL md5sum!"

		unzip download

		rm download

		for it in `ls *md *txt` ; do

			mv ${it} "${plugin}-${it}"

		done

		cp -r * ${destination}

		cd ..

		rm -rf ${plugin}

	else

		echo "not installing ${version}$/${plugin}"

	fi

done < ${plugins}

exit 0

