
Steps to build ZCU208 firmware image:

Install Xilinx Vivado, Vitis and Petalinux 2022.1 under `/opt/xilinx_2022.1`, which will be mounted by the virtual machine for image building.

1. Clone this repository

    ```
    git clone git@github.com:duqiang/RFSoC-PYNQ.git
    cd RFSoC-PYNQ
    ```

2. Download BSP

    ```
    wget https://www.xilinx.com/member/forms/download/xef.html?filename=xilinx-zcu208-v2022.1-04191534.bsp -O boards/ZCU208/ZCU208.dsp
    ```

3. Download prebuilt images

    ```
    wget https://bit.ly/pynq_aarch64_v3_0_1 -O ./pynq/sdbuild/prebuilt/pynq_rootfs.aarch64.tar.gz
    wget https://github.com/Xilinx/PYNQ/releases/download/v3.0.1/pynq-3.0.1.tar.gz -O ./pynq/sdbuild/prebuilt/pynq_sdist.tar.gz
    ```

4. Setup virtual machine

    Follow instructions for installing [VirtualBox](https://wiki.debian.org/VirtualBox#Debian_10_.22Buster.22.2C_Debian_11_.22Bullseye.22.2C_and_Debian_12_.22Bookworm.22) for Debian 11 / 12.

    ```
    sudo apt install vagrant virtualbox virtualbox-ext-pack
    ```

5. Create virtual machine for building PYNQ images

    ```
    vagrant up focal
    vagrant ssh
    ```

6. Inside virtual machine, 

    Setup host:
    ```
    ./setup_host.sh
    ```
    Re-login.

    Build bitstream:
    ```
    cd /workspace
    git clone --recursive https://github.com/duqiang/RFSoC-PYNQ.git
    cd RFSoC-PYNQ
    make -C boards/ZCU208/base
    ```

7. Inside virtual machine, build SD image

    ```
    make BOARD=ZCU208 ZCU208-3.0.1.img
    ```
