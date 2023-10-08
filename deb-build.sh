#!/bin/bash

set -ex
mkdir -p deb-build
cd deb-build
cmake -G "Unix Makefiles" -DEQEMU_BUILD_LOGIN=ON -DCMAKE_BUILD_TYPE=Release ../
make -j 4
