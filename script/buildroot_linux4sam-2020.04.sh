#!/bin/bash
# !! nicht vergessen. Mit $ chmod +x buildroot.sh Datei ausführbar machen
#
# You need the following libraries on your linux-host system (->9.5.1)
sudo apt-get install build-essential automake autoconf libtool pkg-config libdrm-dev libinput-dev libcairo-dev libjpeg-dev libmagic-dev gettext
sudo apt-get install librsvg2-dev liblua5.3-dev libcurl4-openssl-dev      libxkbcommon-dev xkb-data libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt-get install subversion build-essential bison flex gettext libncurses5-dev texinfo autoconf automake libtool mercurial git-core gperf gawk expat curl cvs libexpat-dev bzr unzip bc python-dev
#
# Download/clone sources needed for the buildsystem eg: buildroot and the externals
git clone https://github.com/linux4sam/buildroot-external-microchip.git -b linux4sam-2020.04
git clone https://github.com/linux4sam/buildroot-at91.git -b linux4sam-2020.04
#
# Configure for your target (eg: WLSOM)
cd buildroot-at91/
BR2_EXTERNAL=../buildroot-external-microchip make sama5d27_wlsom1_ek_graphics_defconfig
#
# Now add/remove parts for your image
make menuconfig
#
# Next create new image with the features you added
make
# or
# make -j12
#
# Finally you need to create the SDK/cross-compiler-toolchain that fits to your image ->this creates a tarball:
make sdk
#
# Install (=extract) the tarball
#tar -xvf <TARGET-TUPLE>_sdk-buildroot.tar.gz <path-2-install-tarball>
#
# Finally configure the tarball/cross-compiler environment
#cd <path-2-install-tarball>
#./relocate.sh

