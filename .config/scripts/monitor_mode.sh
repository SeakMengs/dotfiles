#!/bin/bash

# File paths
USER_HYPR_CONFIG="$HOME/.config/hypr/modules/monitor_mode.conf"
SYSTEM_MKINITCPIO_CONFIG="/etc/mkinitcpio.conf"
SYSTEM_NVIDIA_MODPROBE="/etc/modprobe.d/nvidia.conf"
SYSTEM_BLACKLIST_MODPROBE="/etc/modprobe.d/blacklist.conf"
NVIDIA_UTILS_CONF="/usr/lib/modprobe.d/nvidia-utils.conf"

# Check for sudo privileges for system-level changes
check_sudo() {
  if [[ $EUID -ne 0 ]]; then
    echo "This action requires sudo privileges."
    sudo -v || exit 1
  fi
}

# Function to update mkinitcpio MODULES
update_mkinitcpio_modules() {
  local mode=$1
  local modules_to_add
  local modules_to_remove
  local mkinitcpio_content
  mkinitcpio_content=$(cat $SYSTEM_MKINITCPIO_CONFIG)

  if [[ $mode == "external" ]]; then
    modules_to_add="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
    modules_to_remove="nouveau"
  elif [[ $mode == "internal" ]]; then
    modules_to_add="nouveau"
    modules_to_remove="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
  fi

  # Read the current MODULES line
  current_modules=$(echo "$mkinitcpio_content" | grep "^MODULES=" | sed 's/^MODULES=(//;s/)//')

  # Remove unwanted modules
  for module in $modules_to_remove; do
    current_modules=$(echo "$current_modules" | sed -e "s/\b$module\b//g")
  done

  # Add new modules
  updated_modules="$current_modules"
  for module in $modules_to_add; do
    if ! echo "$current_modules" | grep -qw "$module"; then
      updated_modules="$updated_modules $module"
    fi
  done

  # Ensure the MODULES line is updated
  updated_modules=$(echo "$updated_modules" | xargs)
  updated_content=$(echo "$mkinitcpio_content" | sed "s/^MODULES=.*/MODULES=($updated_modules)/")

  echo "$updated_content" | sudo tee $SYSTEM_MKINITCPIO_CONFIG > /dev/null
}

# Function to update modprobe configuration
update_nvidia_utils_modprobe_config() {
  local mode=$1
  if [[ -f $NVIDIA_UTILS_CONF ]]; then
    if [[ $mode == "external" ]]; then
      if grep -q "#blacklist nouveau" $NVIDIA_UTILS_CONF; then
        sudo sed -i 's/#blacklist nouveau/blacklist nouveau/' $NVIDIA_UTILS_CONF
      fi
    elif [[ $mode == "internal" ]]; then
      if grep -q "blacklist nouveau" $NVIDIA_UTILS_CONF; then
        sudo sed -i 's/blacklist nouveau/#blacklist nouveau/' $NVIDIA_UTILS_CONF
      fi
    fi
  fi
}

external_monitor_mode() {
  echo "Switching to external monitor mode..."

  # Update Hyprland config
  echo "Updating Hyprland monitor configuration..."
  cat <<EOL > $USER_HYPR_CONFIG
# Custom mode for external and internal monitor for me because currently I have issue if nvidia is specified to run hyprland then internal monitor will be freeze, temporary fix is to disable ghost monitors

# If use nvidia card, disable internal monitor (Maybe issue with driver)
monitor = eDP-2,disable
monitor = eDP-1,disable

# Specify hyprland to run on nvidia card (Strangely, if I don't specify hyprland to use nvidia card, the hyprland won't run smooth on external monitor)
env = WLR_DRM_DEVICES,$HOME/.config/hypr/nvidia-card:$HOME/.config/hypr/intel-card
EOL

  # Update mkinitcpio config
  # check_sudo
  # echo "Updating mkinitcpio configuration..."
  # update_mkinitcpio_modules "external"

  # Update modprobe config for Nvidia
  echo "Updating Nvidia modprobe configuration..."
  echo "options nvidia_drm modeset=1 fbdev=1
options nvidia NVreg_PreserveVideoMemoryAllocations=1
options nvidia NVreg_TemporaryFilePath=/var/tmp
  " | sudo tee $SYSTEM_NVIDIA_MODPROBE > /dev/null

  # Update modprobe blacklist config
  echo "Updating modprobe blacklist configuration..."
  sudo tee $SYSTEM_BLACKLIST_MODPROBE > /dev/null <<EOL
blacklist nouveau
options nouveau modeset=0

#========Nvidia============
# Uncomment this when using without external monitor to get smooth experience
#blacklist nvidia
#blacklist nvidia-drm
#blacklist nvidia-modeset
#blacklist nvidia-uvm
EOL

  # Update modprobe configuration
  update_nvidia_utils_modprobe_config "external"

  echo "Regenerating initramfs..."
  sudo mkinitcpio -P
  echo "External monitor mode activated. Please reboot."
}

internal_monitor_mode() {
  echo "Switching to internal monitor mode..."

  # Comment out specific lines in Hyprland monitor mode settings
  echo "Updating Hyprland monitor configuration..."
  sed -i '/^monitor = eDP-2,disable/s/^/#/; /^monitor = eDP-1,disable/s/^/#/; /^env = WLR_DRM_DEVICES/s/^/#/' $USER_HYPR_CONFIG

  # Update mkinitcpio config
  # check_sudo
  # echo "Updating mkinitcpio configuration..."
  # update_mkinitcpio_modules "internal"

  # Update modprobe config for Nvidia
  echo "Updating Nvidia modprobe configuration..."
  echo "# options nvidia_drm modeset=1 fbdev=1" | sudo tee $SYSTEM_NVIDIA_MODPROBE > /dev/null

  # Update modprobe blacklist config
  echo "Updating modprobe blacklist configuration..."
  sudo tee $SYSTEM_BLACKLIST_MODPROBE > /dev/null <<EOL
#blacklist nouveau
#options nouveau modeset=0

#========Nvidia============
# Uncomment this when using without external monitor to get smooth experience
blacklist nvidia
blacklist nvidia-drm
blacklist nvidia-modeset
blacklist nvidia-uvm
EOL

  # Update modprobe configuration
 update_nvidia_utils_modprobe_config "internal"


  echo "Regenerating initramfs..."
  sudo mkinitcpio -P
  echo "Internal monitor mode activated. Please reboot."
}

# Main script logic
if [[ $1 == "external" ]]; then
  external_monitor_mode
elif [[ $1 == "internal" ]]; then
  internal_monitor_mode
else
  echo "Usage: $0 {external|internal}"
  exit 1
fi

# Ask user if they want to reboot
read -p "Do you want to reboot now? (y/n, default: y): " reboot_choice
# If no input, default to 'y'
reboot_choice=${reboot_choice:-y}

if [[ $reboot_choice == "y" || $reboot_choice == "Y" ]]; then
  reboot
else
  echo "Please reboot your system later to apply changes."
fi
