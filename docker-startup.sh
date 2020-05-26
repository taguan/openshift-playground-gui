#!/bin/sh

sed -i "s#window.restServerUrl = undefined#window.restServerUrl = '$REST_SERVER_URL'#g" /usr/share/nginx/html/index.html;
nginx -g 'daemon off;';
