#!/bin/bash -xe
WANT_ENV="docker-build docker-run"
. $(dirname $0)/env.sh

# Ensure apt cache is up to date
apt-get update

###########################
# Update system & install general dependencies
###########################

apt-get install -y \
        iproute2 \
        locales \
        wget

apt-get install -y \
    git \
    nano \
    tmux \
    ssh-client \
    libxrender1 \
    python3-pip \
    build-essential \
    devscripts \
    equivs

apt-get install -y \
       libssl-dev \
       zlib1g-dev \
       libncurses5-dev \
       libncursesw5-dev \
       libreadline-dev \
       libsqlite3-dev \
       libgdbm-dev \
       libdb5.3-dev \
       libbz2-dev \
       libexpat1-dev \
       liblzma-dev \
       libffi-dev

###########################
# Clean up
###########################
apt-get clean
if test_environment docker-build; then
    rm -rf /root/.ccache
fi
