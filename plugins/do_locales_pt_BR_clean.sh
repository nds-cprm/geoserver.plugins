#! /usr/bin/bash

geoserver_dir="/opt/tomcat/webapps/geoserver/WEB-INF/lib/"

mkdir -p ${geoserver_dir}

# sane locales pt_BR, by wipe

for jar in $(ls ${geoserver_dir}*.jar);
    do zip -d ${jar} \*pt_BR.properties; done

exit 0
