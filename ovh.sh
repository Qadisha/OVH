#!/bin/bash

OVH_CONSUMER_KEY=""
OVH_APP_KEY=""
OVH_APP_SECRET=""

DOMAIN=""

HTTP_METHOD=""
HTTP_QUERY=""
HTTP_BODY=''

TIME=$(curl -s https://api.ovh.com/1.0/auth/time)

CLEAR_SIGN="$OVH_APP_SECRET+$OVH_CONSUMER_KEY+$HTTP_METHOD+$HTTP_QUERY+$HTTP_BODY+$TIME"
SIG='$1$'$(echo -n $CLEAR_SIGN | openssl dgst -sha1 | sed -e 's/^.* //')

curl -X $HTTP_METHOD -H "Content-Type:application/json;charset=utf-8"  -H "X-Ovh-Application:$OVH_APP_KEY" -H "X-Ovh-Timestamp:$TIME" -H "X-Ovh-Signature:$SIG" -H "X-Ovh-Consumer:$OVH_CONSUMER_KEY" --data "$HTTP_BODY" $HTTP_QUERY


