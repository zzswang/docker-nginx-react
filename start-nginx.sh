#!/bin/sh

echo "setting nginx conf ..."
echo "DEBUG": $DEBUG
echo "APP_VERSION": $APP_VERSION
echo "APP_DIR": $APP_DIR
echo "APP_PATH_PREFIX": $APP_PATH_PREFIX
echo "APP_API_PLACEHOLDER": $APP_API_PLACEHOLDER
echo "APP_API_GATEWAY": $APP_API_GATEWAY
echo "CLIENT_BODY_TIMEOUT": $CLIENT_BODY_TIMEOUT
echo "CLIENT_HEADER_TIMEOUT": $CLIENT_HEADER_TIMEOUT
echo "CLIENT_MAX_BODY_SIZE": $CLIENT_MAX_BODY_SIZE

# replace env for nginx conf
envsubst '$WHITE_LIST $WHITE_LIST_IP $DEBUG $APP_VERSION $APP_DIR $APP_PATH_PREFIX $APP_API_PLACEHOLDER $APP_API_GATEWAY $CLIENT_BODY_TIMEOUT $CLIENT_HEADER_TIMEOUT $CLIENT_MAX_BODY_SIZE' < /etc/nginx/conf.d/app.conf.template > /etc/nginx/conf.d/default.conf

if [ ${WHITE_LIST} = 'off' ]; then
    # delete white list config
    sed -i '/^[ ]*\#[ ]*BEGIN_CONFIG_WHEN_WHITE_LIST_ON/,/^[ ]*\#[ ]*END_CONFIG_WHEN_WHITE_LIST_ON/{d;};' /etc/nginx/conf.d/default.conf
fi

# find all env start with APP_
export SUBS=$(echo $(env | cut -d= -f1 | grep "^APP_" | sed -e 's/^/\$/'))

# replace above envs
echo "inject environments ..."
echo $SUBS

for f in `find "$APP_DIR" -regex ".*\.\(js\|css\|html\|json\|map\)"`; do envsubst "$SUBS" < $f > $f.tmp; mv $f.tmp $f; done

# inject REACT_APP envs
export REACT_SUBS=$(echo $(env | cut -d= -f1 | grep "^REACT_APP_" | sed -e 's/^/\$/'))
echo "inject react app environments ..."
echo $REACT_SUBS

for f in `find "$APP_DIR" -regex ".*\.\(html\)"`; do
    sed -i "s/\"use runtime env\";/'use runtime env';/g" $f
    for e in $REACT_SUBS; do
        eName=$(echo $e | sed -e 's/^\$//');
        sed -i "s/'use runtime env';/'use runtime env'; window._36node[\"$eName\"]=\"$e\";/g" $f
    done
    sed -i "s/'use runtime env';/'use runtime env'; window._36node=window._36node||{};/g" $f
done

for f in `find "$APP_DIR" -regex ".*\.\(html\)"`; do envsubst "$REACT_SUBS" < $f > $f.tmp; mv $f.tmp $f; done

# start nginx
nginx -g 'daemon off;'
exec "$@"
