#!/bin/bash

cd ~/ctomkow.github.io

jellyfin_status=$(curl -I https://jellyfin.abttomkow.ca/web/ 2>/dev/null | head -n 1 | cut -d$' ' -f2)
immich_status=$(curl -I https://immich.abttomkow.ca 2>/dev/null | head -n 1 | cut -d$' ' -f2)
vault_status=$(curl -I https://vault.abttomkow.ca 2>/dev/null | head -n 1 | cut -d$' ' -f2)
drive_status=$(curl -I https://drive.abttomkow.ca/healthz 2>/dev/null | head -n 1 | cut -d$' ' -f2)
galadriel_status=$(curl -I https://galadriel.abttomkow.ca/manage/account/login 2>/dev/null | head -n 1 | cut -d$' ' -f2)

if [ $jellyfin_status != "200" ]; then
	cat $jellyfin_status > _data/jellyfin.yml;
elif [ $immich_status != "200" ]; then
	cat $immich_status > _data/immich.yml
elif [ $vault_status != "200" ]; then
	cat $vault_status > _data/vault.yml
elif [ $drive_status != "200" ]; then
	cat $drive_status > _data/drive.yml
elif [ $galadriel_status != "200" ]; then
	cat $galadriel_status > _data/drive.yml
fi;

if [[ $(date +%R) == "00:00" ]]; then
    date -Is > _data/statuspagecheck.yml
fi

git add . && git commit -m "status update" && git push

