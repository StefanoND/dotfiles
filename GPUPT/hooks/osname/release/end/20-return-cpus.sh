#!/bin/bash

## Load VM variables
source "/etc/libvirt/hooks/qemu.d/name/vm-vars.conf"

## Return CPU cores as per set variable
systemctl set-property --runtime -- user.slice AllowedCPUs="$SYS_TOTAL_CPUS"
systemctl set-property --runtime -- system.slice AllowedCPUs="$SYS_TOTAL_CPUS"
systemctl set-property --runtime -- init.scope AllowedCPUs="$SYS_TOTAL_CPUS"
taskset -pc "$SYS_TOTAL_CPUS" 2 # kthreadd reset

sleep 1
