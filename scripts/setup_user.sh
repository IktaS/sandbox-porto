#!/bin/bash

adduser -D visitor
cp /scripts/.bashrc /home/visitor/.bashrc
mkdir -p /home/visitor/.config/neofetch/
cp /scripts/config.conf /home/visitor/.config/neofetch/config.conf
chmod -R 555 /home/visitor