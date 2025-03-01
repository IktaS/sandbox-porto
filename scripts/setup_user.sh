#!/bin/bash

adduser -D visitor
mkdir -p /home/visitor/.config/fastfetch/
cp /scripts/config.jsonc /home/visitor/.config/fastfetch/config.jsonc
su visitor -c 'bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"'
cp /scripts/.bashrc /home/visitor/.bashrc
cp /scripts/cv.md /home/visitor/cv.md
mkdir /home/visitor/.config/glow
chmod -R 555 /home/visitor
cp /scripts/glow.yml /home/visitor/.config/glow/glow.yml
touch /home/visitor/.bash_history
chmod 777 /home/visitor/.bash_history