#!/bin/bash -xe
WANT_ENV="docker-build docker-run"
. $(dirname $0)/env.sh

# Ensure apt cache is up to date
apt-get update

###########################
# Install LCNC deps
###########################
git clone https://github.com/LinuxCNC/linuxcnc.git --depth 1
cd linuxcnc/debian
./configure uspace noauto
cd ..
mk-build-deps
dpkg -i linuxcnc-build-deps*.deb || true
apt-get -f -y install

apt-get install -y \
        python-gtk2 \
        python-tk \
        python-yapps

###########################
# Clean up
###########################
apt-get clean
if test_environment docker-build; then
    rm -rf /root/.ccache
fi
