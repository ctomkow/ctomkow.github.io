#!/bin/bash

cd ~/ctomkow.github.io

jellyfin_status=$(curl -I --connect-timeout 1 https://jellyfin.abttomkow.ca/web/ 2>/dev/null | head -n 1 | cut -d$' ' -f2)
immich_status=$(curl -I --connect-timeout 1 https://immich.abttomkow.ca 2>/dev/null | head -n 1 | cut -d$' ' -f2)
vault_status=$(curl -I --connect-timeout 1 https://vault.abttomkow.ca 2>/dev/null | head -n 1 | cut -d$' ' -f2)
drive_status=$(curl -I --connect-timeout 1 https://drive.abttomkow.ca/healthz 2>/dev/null | head -n 1 | cut -d$' ' -f2)
galadriel_status=$(curl -I --connect-timeout 1 https://galadriel.abttomkow.ca/manage/account/login 2>/dev/null | head -n 1 | cut -d$' ' -f2)

if [ "$jellyfin_status" != "$(cat _data/jellyfin.yml)" ]; then
	echo $jellyfin_status > _data/jellyfin.yml;
fi;
if [ "$immich_status" != "$(cat _data/immich.yml)" ]; then
	echo $immich_status > _data/immich.yml
fi;
if [ "$vault_status" != "$(cat _data/vault.yml)" ]; then
	echo $vault_status > _data/vault.yml
fi;
if [ "$drive_status" != "$(cat _data/drive.yml)" ]; then
	echo $drive_status > _data/drive.yml
fi;
if [ "$galadriel_status" != "$(cat _data/galadriel.yml)" ]; then
	echo $galadriel_status > _data/galadriel.yml
fi;

if [[ $(date +%R) == "21:23" ]]; then
    date -Is > _data/statuspage.yml
fi

git add . && git commit -m "status update" && git push

