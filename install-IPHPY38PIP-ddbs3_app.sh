#!/usr/bin/env bash
#
# boilerplate install script
#
cd /home/ubuntu
touch $(date '+%Y-%m-%d_%H-%M-%S')_start_of_install_ddbs3_app

su ubuntu

# Python Install
# ==============
# get requirements.txt file from repository
# as it is a private repository we get it from s3
#wget -O /home/ubuntu/requirements.txt "https://raw.githubusercontent.com/pierre-pvln/ddbs3-to-csv_vandenHerik/master/code/app/requirements.txt
aws s3 cp s3://iph-code-repository/ddbs3-to-csv/code/app/requirements.txt /home/ubuntu/requirements.txt

echo [INFO ] Installing python app ...
python3 -m venv env
source env/bin/activate
python3 -m pip install -r /home/ubuntu/requirements.txt
python3 -m pip freeze >/home/ubuntu/as_build.txt
deactivate

# Polygon Install
# ===============

echo [INFO ] Cloning polygons from public github ...
# get the polygons
git clone https://github.com/pierre-pvln/myPolygons.git /home/ubuntu/polygons


# App Install
# ===========
echo [INFO ] Cloning app ...
DIR="/home/ubuntu/ddbs3-to-csv/"
if [ ! -d "$DIR" ]; then
  # if $DIR does not exist.
  mkdir --parents "$DIR"
fi
aws s3 cp s3://iph-code-repository/ddbs3-to-csv/ /home/ubuntu/ddbs3-to-csv --recursive

cp /home/ubuntu/ddbs3-to-csv/run_ec2/run-python-script.sh /home/ubuntu/run-python-script.sh

# and finalize
cd /home/ubuntu
chmod +x /home/ubuntu/*.sh

touch $(date '+%Y-%m-%d_%H-%M-%S')_end_of_install_ddbs3_app
