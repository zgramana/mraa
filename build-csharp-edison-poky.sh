#!/bin/bash
set -e
source /opt/poky-edison/1.7.2/environment-setup-core2-32-poky-linux
rm -Rf build/*
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchains/oe-sdk_cross.cmake -DBUILDSWIGJAVA=off -DBUILDSWIGNODE=OFF -DBUILDSWIGPYTHON=OFF ..
make
cd ..