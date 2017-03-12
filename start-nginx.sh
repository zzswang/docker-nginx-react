#!/usr/bin/with-contenv sh

echo "setting envrionment..."
echo "APP_DIR": $BASE_URL
echo "API_PLACEHOLDER": $API_PLACEHOLDER
echo "API_GATEWAY": $API_GATEWAY
envsubst '$APP_DIR $API_PLACEHOLDER $API_GATEWAY' < /etc/nginx/conf.d/app.conf.template > /etc/nginx/conf.d/default.conf

# start nginx
nginx
exec "$@"
