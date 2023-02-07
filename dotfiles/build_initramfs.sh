#!/bin/bash

KERNEL_VERSION=$(ls /lib/modules)
dracut --force --kver "$KERNEL_VERSION" --hostonly --no-hostonly-cmdline --uefi /boot/initramfs-linux.img
dracut --force --kver "$KERNEL_VERSION" --uefi /boot/initramfs-linux-fallback.img
