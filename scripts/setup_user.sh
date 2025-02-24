#!/bin/bash

adduser -D visitor
cp /scripts/.bashrc /home/visitor/.bashrc
mkdir -p /home/visitor/.config/fastfetch/
cp /scripts/config.jsonc /home/visitor/.config/fastfetch/config.jsonc
chmod -R 555 /home/visitor