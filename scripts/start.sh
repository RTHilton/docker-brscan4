#/usr/bin/brsaneconfig4 -a name=$SCANNER_NAME model=$SCANNER_MODEL ip=$SCANNER_IP_ADDRESS
#/usr/bin/brscan-skey
mkdir -p /scantemp
mkdir -p /scans
cd /scantemp
/opt/brother/docker_skey/bin/brother-scand -c /opt/brother/docker_skey/brother.config
while true; do
  sleep 300
done
exit 0
