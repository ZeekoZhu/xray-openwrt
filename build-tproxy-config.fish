#!/usr/bin/fish

set -l config_address ""
set -l config_id ""
set -l config_serverName ""

if test -z $config_address; or test -z $config_id; or test -z $config_serverName
  echo "Please edit 'build-tproxy-config.fish' to provide a valid xray server information, or create 'package/data/etc/xray/config.json' yourself."
  exit 1
end

rm -rf package/data/etc/xray
mkdir -p package/data/etc/xray

set -l default_config ./sample-config.json
set -l package_config ./package/data/etc/xray/config.json

echo Server address: $config_address
echo Client id: $config_id
echo Server name: $config_serverName

sed -e "s/TODO:address/$config_address/g" \
    -e "s/TODO:id/$config_id/g" \
    -e "s/TODO:serverName/$config_serverName/g" $default_config \
    > $package_config


echo "Downloading extended rules data from Loyalsoldier/v2ray-rules-dat"
pushd ./package/data/etc/xray
wget -q --show-progress https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
wget -q --show-progress https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
popd
