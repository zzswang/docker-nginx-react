echo "into envsubst: "
echo "BASE_URL": $BASE_URL
envsubst '$BASE_URL' < /etc/nginx/conf.d/mysite.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'