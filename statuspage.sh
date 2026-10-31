#!/bin/bash

cd ~/ctomkow.github.io
echo $(curl -I https://jellyfin.abttomkow.ca/web/ 2>/dev/null | head -n 1 | cut -d$' ' -f2) > _data/jellyfin.yml
echo $(curl -I https://immich.abttomkow.ca 2>/dev/null | head -n 1 | cut -d$' ' -f2) > _data/immich.yml
echo $(curl -I https://vault.abttomkow.ca 2>/dev/null | head -n 1 | cut -d$' ' -f2) > _data/vault.yml
echo $(curl -I https://drive.abttomkow.ca/healthz 2>/dev/null | head -n 1 | cut -d$' ' -f2) > _data/drive.yml
echo $(curl -I https://galadriel.abttomkow.ca/manage/account/login 2>/dev/null | head -n 1 | cut -d$' ' -f2) > _data/galadriel.yml

if [[ $(date +%R) == "00:00" ]]; then
    date -Is > _data/statuspagecheck.yml
fi

git add . && git commit -m "status update" && git push

