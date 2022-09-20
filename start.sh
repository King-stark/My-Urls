#/bin/sh

sed -i "s#https://s.ops.ci#https://${MYURLS_DOMAIN}#g" /app/public/index.html

/app/myurls -domain ${MYURLS_DOMAIN} -conn $RDSHOST:$RDSPORT -passwd $RDSPASSWORD -ttl ${MYURLS_TTL}

nginx -g 'daemon off;'
