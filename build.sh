#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install micro wget

wget https://github.com/displaylink-rpm/displaylink-rpm/releases/download/v6.1.0-2/fedora-41-displaylink-1.14.7-4.github_evdi.x86_64.rpm
rpm-ostree install ./fedora-41-displaylink-1.14.7-4.github_evdi.x86_64.rpm

dkms status
KERN=$(ls /usr/src/kernels | head --lines=1)
dkms install evdi/1.14.7 -k $KERN
dkms status

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

#systemctl enable podman.socket
