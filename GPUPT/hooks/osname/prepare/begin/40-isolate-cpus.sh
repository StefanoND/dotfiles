#!/bin/bash

## Load VM variables
source "/etc/libvirt/hooks/qemu.d/name/vm-vars.conf"

## Isolate CPU cores as per set variable
systemctl set-property --runtime -- user.slice AllowedCPUs="$VM_ISOLATED_CPUS"
systemctl set-property --runtime -- system.slice AllowedCPUs="$VM_ISOLATED_CPUS"
systemctl set-property --runtime -- init.scope AllowedCPUs="$VM_ISOLATED_CPUS"
irq-affinity mask "$VM_MASK_CPUS"
taskset -pc "$VM_MASK_CPUS" 2

sleep 1
