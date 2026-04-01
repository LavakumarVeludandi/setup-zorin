#!/bin/bash

# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root (use sudo ./fix_nvidia.sh)"
  exit
fi

echo "--- 1. Updating System Repositories ---"
apt update

echo "--- 2. Installing NVIDIA Driver 580 (Recommended for A1000) ---"
# Installs the 580 driver and the necessary toolkit
apt install -y nvidia-driver-580 nvidia-settings libnvidia-encode-580

echo "--- 3. Unforcing Wayland in GDM3 ---"
# Ensures Wayland is not disabled in the login manager
sed -i 's/^#WaylandEnable=false/WaylandEnable=true/' /etc/gdm3/custom.conf
sed -i 's/WaylandEnable=false/WaylandEnable=true/' /etc/gdm3/custom.conf

echo "--- 4. Disabling NVIDIA's Wayland Blocklist ---"
# Overrides the system rule that hides Wayland when NVIDIA is detected
ln -sf /dev/null /etc/udev/rules.d/61-gdm.rules

echo "--- 5. Adding Modeset & Power Management Flags ---"
# Adds 'nvidia-drm.modeset=1' for monitor stability 
# and 'NVreg_PreserveVideoMemoryAllocations=1' to fix wake-from-sleep glitches
if ! grep -q "nvidia-drm.modeset=1" /etc/default/grub; then
  sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 /' /etc/default/grub
  update-grub
  echo "Grub updated with Wayland compatibility flags."
else
  echo "Flags already present in Grub."
fi

echo "--- 6. Finalizing Setup ---"
# This ensures NVIDIA services are ready for Wayland suspend/resume
systemctl enable nvidia-suspend.service nvidia-hibernate.service nvidia-resume.service

echo "--- FINISHED ---"
echo "Please REBOOT your laptop now."
echo "On the login screen, use the Gear Icon (⚙️) and select 'Zorin Desktop'."
