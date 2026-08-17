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
    abootimg \
    sshpass \
    zstd \
    uuid-runtime \
    dosfstools \
    mtools \
    kmod \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*


# Ubuntu 22.04's iputils-ping merged ping/ping6 into a single "ping" binary
# and dropped the "ping6" symlink/command entirely. NVIDIA's
 # l4t_initrd_flash_internal.sh (ping_device()) hard-codes "ping6" and swallows
# its stdout/stderr, so a missing ping6 fails completely silently: no ICMPv6
# echo-request is ever emitted, and the flash hangs at "Waiting for device to
# expose ssh" with no visible error. iputils' ping detects IPv6 mode from its
# own argv[0] basename, so a plain symlink is sufficient (no wrapper needed).
RUN ln -sf "$(command -v ping)" /usr/bin/ping6

# Fix the shell (NVIDIA scripts hate dash)
RUN #ln -sf /bin/bash /bin/sh

WORKDIR /Linux_for_Tegra

ENTRYPOINT ["/bin/bash"]
