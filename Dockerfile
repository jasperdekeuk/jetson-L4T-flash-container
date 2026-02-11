ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE}

# Prevent interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# All required packages for L4T to be able to do flashing (e.g. openssh-server and nfs-kerner-server)
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    bzip2 \
    sudo \
    usbutils \
    python3 \
    python3-distutils \
    mkbootimg \
    cpp \
    device-tree-compiler \
    qemu-user-static \
    openssh-server \
    nfs-kernel-server \
    rpcbind \
    cpio \
    binutils \
    libxml2-utils \
    iproute2 \
    udev \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Fix the shell (NVIDIA scripts hate dash)
RUN #ln -sf /bin/bash /bin/sh

WORKDIR /Linux_for_Tegra

ENTRYPOINT ["/bin/bash"]