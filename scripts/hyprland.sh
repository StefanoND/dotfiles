#! /bin/env bash

if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
  yes | sudo pacman -S hyprland-git --needed
fi

# PACMAN
PKGS=(
  'linux-xanmod'
  'linux-xanmod-headers'
  'libvdpau'
  'libxnvctrl'
  'mesa'
  'lib32-mesa'
  'libva-mesa-driver'
  'mesa-vdpau'
  'opencl-clover-mesa'
  'xorg-xwayland'
  'vulkan-headers'
  'vulkan-validation-layers'
  'vulkan-tools'
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG}"
  echo
  yes | sudo pacman -S "$PKG" --needed
  sleep 1s
done

if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
  echo
  echo "NVidia GPU found"
  echo
  sleep 1s

  echo
  echo "Installing NVidia's Proprietary Stuff"
  echo

  PKGNV=(
    'nvidia-dkms'
    'libva-nvidia-driver'
    'nvidia-utils'
    'lib32-nvidia-utils'
    'opencl-nvidia'
    'lib32-opencl-nvidia'
    'libglvnd'
    'lib32-libglvnd'
    'nvidia-settings'
  )

 # yes | sudo pacman -S linux-xanmod linux-xanmod-headers nvidia-dkms libva-nvidia-driver nvidia-utils lib32-nvidia-utils opencl-nvidia lib32-opencl-nvidia libglvnd lib32-libglvnd nvidia-settings libvdpau libxnvctrl mesa lib32-mesa libva-mesa-driver mesa-vdpau opencl-clover-mesa xorg-xwayland vulkan-headers vulkan-validation-layers vulkan-tools tpm2-tss

  for PKG in "${PKGNV[@]}"; do
    echo
    echo "INSTALLING: ${PKG}"
    echo
    yes | sudo pacman -S "$PKG" --needed
    sleep 1s
  done

  # if ! [[ grep -qi '__GLX_VENDOR_LIBRARY_NAME' ]]; then
  #   echo '__GLX_VENDOR_LIBRARY_NAME=nvidia' | sudo tee -a /etc/environment
  # else
  #   sudo sed -i 's/__GLX_VENDOR_LIBRARY_NAME.*/__GLX_VENDOR_LIBRARY_NAME=nvidia/g' /etc/environment
  # fi
  # if ! [[ grep -qi 'VK_DRIVER_FILES' ]]; then
  #   echo 'VK_DRIVER_FILES=/usr/share/vulkan/icd.d/nvidia_icd.json' | sudo tee -a /etc/environment
  # else
  #   sudo sed -i 's/VK_DRIVER_FILES.*/VK_DRIVER_FILES=/usr/share/vulkan/icd.d/nvidia_icd.json/g' /etc/environment
  # fi
  # if ! [[ grep -qi 'VK_LAYER_PATH' ]]; then
  #   echo 'VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d' | sudo tee -a /etc/environment
  # else
  #   sudo sed -i 's/VK_LAYER_PATH.*/VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d/g' /etc/environment
  # fi

  sleep 1s

  if ! [[ -f /etc/modprobe.d/nvidia.conf ]]; then
    sudo touch /etc/modprobe.d/nvidia.conf
    sync
    echo 'options nvidia_drm modeset=1' | sudo tee /etc/modprobe.d/nvidia.conf
    echo 'options nvidia_drm fbdev=1' | sudo tee -a /etc/modprobe.d/nvidia.conf
    echo 'options nvidia NVreg_PreserveVideoMemoryAllocations=1' | sudo tee -a /etc/modprobe.d/nvidia.conf
    echo 'options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"' | sudo tee -a /etc/modprobe.d/nvidia.conf
  fi

  if ! [[ -f /etc/dracut.conf.d/nvidia.conf ]]; then
    sudo touch /etc/dracut.conf.d/nvidia.conf
    sync
    echo 'force_drivers+=" nvidia nvidia_modeset nvidia_uvm nvidia_drm "' > /etc/dracut.conf.d/nvidia.conf
  fi

  sudo dracut-rebuild
  sync

  # GRUB=`cat /etc/default/grub | grep "GRUB_CMDLINE_LINUX_DEFAULT" | rev | cut -c 2- | rev`
  # sleep 1s
  # GRUB+=" nouveau.modeset=0 nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia.NVreg_PreserveVideoMemoryAllocations=1\""
  # sleep 1s
  # sudo sed -ie "s|^GRUB_CMDLINE_LINUX_DEFAULT.*|${GRUB}|g" /etc/default/grub
  #
  # sudo update-grub
  # sync

  sudo systemctl enable nvidia-suspend.service
  sudo systemctl enable nvidia-hibernate.service
  sudo systemctl enable nvidia-resume.service
fi


## Add these to hyprland.conf
# env = DRI_PRIME,pci-0000_01_00_0 # If hybrid laptop
# env = __VK_LAYER_NV_optimus,NVIDIA_only # If hybrid laptop
# env = __GLX_VENDOR_LIBRARY_NAME,nvidia
# env = LIBVA_DRIVER_NAME,nvidia
# env = XDG_SESSION_TYPE,wayland
# env = GBM_BACKEND,nvidia-drm
# env = NVD_BACKEND,direct # VA-API Hardware Acceleration
# env = ELECTRON_OZONE_PLATFORM_HINT,auto # Fixes flickering in Electron/CEF Apps

## To open electron and cef apps add the following arguments to them
# --enable-features=UseOzonePlatform --ozone-platform=wayland
