#!/bin/bash

echo "setting envrionment..."
echo "BASE_URL": $BASE_URL
envsubst '$BASE_URL $API_REGEX $API_GATEWAY' < /etc/nginx/conf.d/mysite.template > /etc/nginx/conf.d/default.conf
nginx -g "daemon off;"
exec "$@"