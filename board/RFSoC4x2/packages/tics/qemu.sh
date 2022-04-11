#! /bin/bash
# Copyright (C) 2022 Xilinx, Inc
# SPDX-License-Identifier: BSD-3-Clause

set -x
set -e

. /etc/environment

dest=/usr/local/share/pynq-venv/lib/python3.8/site-packages/xrfclk

cd /root/tics_build
sudo cp -a . $dest

cd /root
rm -rf tics_build