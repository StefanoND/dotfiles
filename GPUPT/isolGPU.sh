#!/usr/bin/env bash
#
# Isolate SECONDARY GPU to passthrough to VMs

NVGPU="nvidia"
AMDGPU="amd/ati"
INTELGPU="intel"
CHOSENGPU="n"
VALIDGPU="n"

while [[ ${VALIDGPU,,} = n ]]; do
    read -p "Which GPU you want to isolate? 1 = NVidia | 2 = AMD/ATI | 3 = Intel: " SELECTEDGPU
    if [[ ${SELECTEDGPU,,} = 1 ]]; then
      CHOSENGPU=$NVGPU
    elif [[ ${SELECTEDGPU,,} = 2 ]]; then
      CHOSENGPU=$AMDGPU
    elif [[ ${SELECTEDGPU,,} = 3 ]]; then
      CHOSENGPU=$INTELGPU
    fi
    if lspci -nn | grep -iE "0300|0403" | grep -iq "$CHOSENGPU"; then
      VALIDGPU=y
    else
      echo
      printf "Could not find any %s gpu, try again" "$CHOSENGPU"
      echo
      CHOSENGPU="n"
    fi
done

# Grep GPU's VGA ID
GPUVGAID="$(lspci -nn | grep -iE "0300" | grep -iE "$CHOSENGPU" | grep -Eo "[[:xdigit:]]{4}:[[:xdigit:]]{4}")"
# Grep GPU's Audio ID
GPUAUDID="$(lspci -nn | grep -iE "0403" | grep -iE "$CHOSENGPU" | grep -Eo "[[:xdigit:]]{4}:[[:xdigit:]]{4}")"

# Join GPU's VGA and Audio IDs together
GPUIDS="$GPUVGAID,$GPUAUDID"

echo
echo 'Checking if vfio-pci.ids=xxxx:xxxx is present, populate if not'
echo
if ! grep -iEq "vfio-pci.ids=$GPUIDS" /etc/default/grub; then
  echo
  printf "\"vfio-pci.ids=%s\" not found, adding to \"/etc/default/grub\"" "$GPUIDS"
  echo
  sudo sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"vfio-pci.ids=$GPUIDS /g" /etc/default/grub
  sync
else
  echo
  printf "\"vfio-pci.ids=%s\" found, skipping to next step" "$GPUIDS"
  echo
fi

echo
echo 'Checking if rd.driver.pre=vfio-pci is present, populate if not'
echo
if ! grep -iEq 'rd.driver.pre=vfio-pci' /etc/default/grub; then
  echo
  printf "\"rd.driver.pre=vfio-pci\" not found, adding to \"/etc/default/grub\""
  echo
  sudo sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"rd.driver.pre=vfio-pci/g" /etc/default/grub
  sync
else
  echo
  printf "\"rd.driver.pre=vfio-pci\" found, skipping to next step"
  echo
fi
# sudo sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"rd.driver.pre=vfio-pci vfio-pci.ids=$GPUIDS /g" /etc/default/grub

echo
echo 'Updating grub'
echo
sleep 1s
sudo update-grub
sleep 1s

echo
echo 'Checking for existing "vfio.conf" file inside "/etc/modprobe.d"'
echo
if [[ -f /etc/modprobe.d/vfio.conf ]]; then
  echo
  echo '"vfio.conf" found, backing it up to file inside "/etc/modprobe.d/vfio.conf.old"'
  echo
  sudo mv /etc/modprobe.d/vfio.conf /etc/modprobe.d/vfio.conf.old
  sync
  sleep 1s
fi

printf "vfio vfio_iommu_type1 vfio_pci ids=%s\n" "$GPUIDS" | sudo tee /etc/modules-load.d/vfio.conf

echo
echo 'Creating a new "vfio.conf" file inside "/etc/modprobe.d/"'
echo
sudo touch /etc/modprobe.d/vfio.conf
sync
echo
echo 'Populating /etc/modprobe.d/vfio.conf with :'
echo
printf "options vfio-pci ids=%s\n" "$GPUIDS" | sudo tee /etc/modprobe.d/vfio.conf
printf "softdep nouveau pre: vfio vfio_pci\n" | sudo tee -a /etc/modprobe.d/vfio.conf
printf "softdep nvidia pre: vfio vfio_pci\n" | sudo tee -a /etc/modprobe.d/vfio.conf
printf "softdep nvidia_drm pre: vfio vfio_pci\n" | sudo tee -a /etc/modprobe.d/vfio.conf
printf "softdep nvidia-* pre: vfio vfio_pci\n" | sudo tee -a /etc/modprobe.d/vfio.conf
sync
sleep 1s

echo
echo 'Updating mkinitcpio'
echo
sleep 1s
sudo mkinitcpio -P

echo
echo "Done..."
echo
sleep 1s
echo
echo "Press Y to reboot now or N if you plan to manually reboot later."
echo
read REBOOT
if [ "${REBOOT,,}" = y ]; then
    reboot
fi

exit 0
