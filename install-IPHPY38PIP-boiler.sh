#!/usr/bin/env bash
#
# boilerplate install script
#
cd /home/ubuntu
touch $(date '+%Y-%m-%d_%H-%M-%S')_start_of_install_boilerplate

su ubuntu

# Python Install
# ==============
echo [INFO ] Installing python base ...
sudo apt-get install python3-pip -y
sudo apt-get install python3-venv -y
python3 -m pip install --user --upgrade pip

# and finalize
touch $(date '+%Y-%m-%d_%H-%M-%S')_end_of_install_boilerplate
