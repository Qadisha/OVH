#!/bin/bash

OVH_CONSUMER_KEY=""
OVH_APP_KEY=""
OVH_APP_SECRET=""
DOMAIN=""
TIME=$(curl -s https://api.ovh.com/1.0/auth/time)
CLEAR_SIGN="$OVH_APP_SECRET+$OVH_CONSUMER_KEY+$HTTP_METHOD+$HTTP_QUERY+$HTTP_BODY+$TIME"
SIG='$1$'$(echo -n $CLEAR_SIGN | openssl dgst -sha1 | sed -e 's/^.* //')


# Get existing DNS
HTTP_METHOD="GET"
HTTP_QUERY="https://api.ovh.com/1.0/domain/$DOMAIN/nameServer"
HTTP_BODY=''

NSSERVERS=$(curl -X $HTTP_METHOD -H "Content-Type:application/json;charset=utf-8"  -H "X-Ovh-Application:$OVH_APP_KEY" -H "X-Ovh-Timestamp:$TIME" -H "X-Ovh-Signature:$SIG" -H "X-Ovh-Consumer:$OVH_CONSUMER_KEY" --data "$HTTP_BODY" $HTTP_QUERY )

# Add Cloudflare DNS
HTTP_METHOD="POST"
HTTP_QUERY="https://api.ovh.com/1.0/domain/$DOMAIN/nameServer"
HTTP_BODY="{\"nameServer\": [{\"host\": \"ken.ns.cloudflare.com\"},{\"host\": \"nina.ns.cloudflare.com\"}]}"

curl -X $HTTP_METHOD -H "Content-Type:application/json;charset=utf-8"  -H "X-Ovh-Application:$OVH_APP_KEY" -H "X-Ovh-Timestamp:$TIME" -H "X-Ovh-Signature:$SIG" -H "X-Ovh-Consumer:$OVH_CONSUMER_KEY" --data "$HTTP_BODY" $HTTP_QUERY



# Delete existing DNS
for i in $(echo $NSSERVERS | sed 's/\[//g; s/\]//g' | tr "," "\n")
do
   HTTP_METHOD='DELETE'
   HTTP_QUERY='https://api.ovh.com/1.0/domain/impreseunite.net/nameServer/'$i
   TIME=$(curl -s https://api.ovh.com/1.0/auth/time)
   CLEAR_SIGN="$OVH_APP_SECRET+$OVH_CONSUMER_KEY+$HTTP_METHOD+$HTTP_QUERY+$HTTP_BODY+$TIME"
   SIG='$1$'$(echo -n $CLEAR_SIGN | openssl dgst -sha1 | sed -e 's/^.* //')

   DELETENSSERVER=$(curl -X $HTTP_METHOD -H "Content-Type:application/json;charset=utf-8"  -H "X-Ovh-Application:$OVH_APP_KEY" -H "X-Ovh-Timestamp:$TIME" -H "X-Ovh-Signature:$SIG" -H "X-Ovh-C>
   echo $DELETENSSERVER
done

