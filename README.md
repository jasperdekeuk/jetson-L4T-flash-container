# jetson-L4T-flash-container

A minimal Docker-based environment for flashing NVIDIA Jetson devices using the official `Linux_for_Tegra` (L4T) tools,
without requiring a specific host OS.

## Why?

Flashing Jetson devices normally requires:

- Ubuntu host machine (specific versions)
- The containers provided by Nvidia only support SDK Manager options and not full flexibility of L4T

This project provides:

- A clean Docker environment with all required dependencies
- Full access to `Linux_for_Tegra` tools
- No SDK Manager restrictions
- Freedom to run any L4T flashing or recovery commands
- Host OS independence

You only need Docker/ Podman installed on your machine.

---

## How It Works

1. You download the official `Linux_for_Tegra` directory from NVIDIA.
2. Mount it into the container.
3. Enter the container shell.
4. Run any L4T flashing commands as usual.
---

## Setup

> Make sure the device is in reccovery mode, to be able to flash it. If the device already has a running OS you can do this with `sudo reboot --force forced-recovery`

1. Download Linux_for_Tegra from [official Nvidia page](https://developer.nvidia.com/embedded/jetson-linux-archive)
2. Extract `tar xf Jetson_Linux_R36.4.3_aarch64.tbz2` (add your specific file to it, if desired)
3. Start the container in interactive mode and run your commands in the container
```shell
docker run -it --rm --privileged --network host   -v /dev/bus/usb:/dev/bus/usb/   -v /dev:/dev   -v /run/nvidia_initrd_flash/docker_host_network:/run/nvidia_initrd_flash/docker_host_network   -v "${PWD}/Linux_for_Tegra":/Linux_for_Tegra:slave   -p 2222:22   jetson-flasher-engine
``` 
4. Install missing dependencies and fix file permissions
```shell
sudo ./tools/l4t_flash_prerequisites.sh 
```
5. Run any command you usually do, like e.g. (QSPI for Jetson AGX Orin):
```shell
sudo ./flash.sh p3737-0000-p3701-0000-qspi internal
```