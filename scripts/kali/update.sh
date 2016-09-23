#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get -y update
# apt-get dist-upgrade
# install curl to fix broken wget while retrieving content from secured sites
DEBIAN_FRONTEND=noninteractive apt-get -y install curl
