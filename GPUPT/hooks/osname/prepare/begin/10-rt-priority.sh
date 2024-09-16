#!/bin/bash -x

LOG=/tmp/libvirthook.log
QEMU=qemu-system-x86_64

if [[ $2 == "start"* ]]; then
  if pid=$(pidof "$QEMU"); then
    chrt -f -p 1 "$pid"
    if [ $? = 0 ]; then
      echo "$(date) INFO: real-time scheduling SET for $QEMU pid: $pid" >> "$LOG"
    else
      echo "$(date) ERROR: real-time scheduling FAILED for $QEMU pid: $pid" >> "$LOG"
    fi
  fi
fi
