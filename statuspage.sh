#!/bin/bash

cd ~/ctomkow.github.io

jellyfin_status=$(curl -I https://jellyfin.abttomkow.ca/web/ 2>/dev/null | head -n 1 | cut -d$' ' -f2)
immich_status=$(curl -I https://immich.abttomkow.ca 2>/dev/null | head -n 1 | cut -d$' ' -f2)
vault_status=$(curl -I https://vault.abttomkow.ca 2>/dev/null | head -n 1 | cut -d$' ' -f2)
drive_status=$(curl -I https://drive.abttomkow.ca/healthz 2>/dev/null | head -n 1 | cut -d$' ' -f2)
galadriel_status=$(curl -I https://galadriel.abttomkow.ca/manage/account/login 2>/dev/null | head -n 1 | cut -d$' ' -f2)

if [ $jellyfin_status != "200" ]; then
	echo $jellyfin_status > _data/jellyfin.yml;
fi;
if [ $immich_status != "200" ]; then
	echo $immich_status > _data/immich.yml
fi;
if [ $vault_status != "200" ]; then
	echo $vault_status > _data/vault.yml
fi;
if [ $drive_status != "200" ]; then
	echo $drive_status > _data/drive.yml
fi;
if [ $galadriel_status != "200" ]; then
	echo $galadriel_status > _data/drive.yml
fi;

if [[ $(date +%R) == "00:00" ]]; then
    date -Is > _data/statuspagecheck.yml
fi

git add . && git commit -m "status update" && git push

