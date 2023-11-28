# Kali Pi5 Image Builder

Welcome to the Kali Pi5 Image Builder repository! This script automates the creation of a customized Kali Linux image for Raspberry Pi 5 using the latest Arm build scripts provided by Kali Linux.

## Scripts

### Script 1: GUI Version

```bash
#!/bin/bash

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
  zenity --error --text="Please run this script as root."
  exit 1
fi

# Ask the user if they watched a YouTube tutorial
watched_tutorial=$(zenity --list --title="YouTube Tutorial" --text="Did you watch a YouTube tutorial for help?" --column="Choice" Yes No --width=250 --height=150)

if [ "$watched_tutorial" == "Yes" ]; then
  youtube_link="https://www.youtube.com/"
  zenity --info --text="Opening the YouTube tutorial..."
  xdg-open $youtube_link
fi

# Ask the user for architecture
arch_choice=$(zenity --list --title="Select Architecture" --text="Select the architecture:" --column="Choice" arm64 armel armhf --width=250 --height=200)

case $arch_choice in
  arm64)
    arch="arm64"
    ;;
  armel)
    arch="armel"
    ;;
  armhf)
    arch="armhf"
    ;;
  *)
    zenity --error --text="Invalid choice. Exiting."
    exit 1
    ;;
esac

# Ask the user for desktop environment
desktop_choice=$(zenity --list --title="Select Desktop Environment" --text="Select the desktop environment:" --column="Choice" xfce gnome kde i3 lxde mate e17 none slim --width=250 --height=300)

case $desktop_choice in
  xfce)
    desktop="xfce"
    ;;
  gnome)
    desktop="gnome"
    ;;
  kde)
    desktop="kde"
    ;;
  i3)
    desktop="i3"
    ;;
  lxde)
    desktop="lxde"
    ;;
  mate)
    desktop="mate"
    ;;
  e17)
    desktop="e17"
    ;;
  none)
    desktop="none"
    ;;
  slim)
    desktop="slim"
    ;;
  *)
    zenity --error --text="Invalid choice. Exiting."
    exit 1
    ;;
esac

# Run the Raspberry Pi 5 script with specified options
zenity --info --text="Running the Raspberry Pi 5 script with architecture: $arch and desktop: $desktop."
sudo ./raspberry-pi5.sh --arch $arch --desktop $desktop

# Download and Install Raspberry Pi Imager
zenity --info --text="Downloading and installing Raspberry Pi Imager..."
sudo apt install snapd
sudo snap install rpi-imager

# Open Raspberry Pi Imager
zenity --info --text="Opening Raspberry Pi Imager..."
rpi-imager
```
### Script 2: CLI Version
```bash
#!/bin/bash

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Ask the user if they watched a YouTube tutorial
read -p "Did you watch a YouTube tutorial for help? (yes/no): " watched_tutorial

if [ "$watched_tutorial" == "yes" ]; then
  youtube_link="https://www.youtube.com/"
  echo "Opening the YouTube tutorial..."
  xdg-open $youtube_link
fi

# Ask the user for architecture
echo "Select the architecture:"
echo "1. arm64"
echo "2. armel"
echo "3. armhf"
read -p "Enter the number (1-3): " arch_choice

case $arch_choice in
  1)
    arch="arm64"
    ;;
  2)
    arch="armel"
    ;;
  3)
    arch="armhf"
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

# Ask the user for desktop environment
echo "Select the desktop environment:"
echo "1. xfce"
echo "2. gnome"
echo "3. kde"
echo "4. i3"
echo "5. lxde"
echo "6. mate"
echo "7. e17"
echo "8. none (minimal)"
echo "9. slim (no desktop manager & no Kali tools)"
read -p "Enter the number (1-9): " desktop_choice

case $desktop_choice in
  1)
    desktop="xfce"
    ;;
  2)
    desktop="gnome"
    ;;
  3)
    desktop="kde"
    ;;
  4)
    desktop="i3"
    ;;
  5)
    desktop="lxde"
    ;;
  6)
    desktop="mate"
    ;;
  7)
    desktop="e17"
    ;;
  8)
    desktop="none"
    ;;
  9)
    desktop="slim"
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

# Run the Raspberry Pi 5 script with specified options
echo "Running the Raspberry Pi 5 script with architecture: $arch and desktop: $desktop."
sudo ./raspberry-pi5.sh --arch $arch --desktop $desktop

# Download and Install Raspberry Pi Imager
echo "Downloading and installing Raspberry Pi Imager..."
sudo apt update
sudo apt install snapd
sudo snap install rpi-imager

# Open Raspberry Pi Imager
echo "Opening Raspberry Pi Imager..."
rpi-imager
```
## Usage
Choose the appropriate script based on your preference:
### Script 1: GUI Version
-Provides a graphical interface for ease of use.
-Execute the script:
```shell 
sudo bash GUI_Kali-Pi5-Image-Builder.sh
```
### Script 2: CLI Version
-Runs in the command line for users who prefer a text-based interface.
-Execute the script:
```shell 
sudo bash Kali-Pi5-Image-Builder.sh
```
###**Note**: Ensure that you have the necessary permissions to execute the scripts with **sudo**. If not, run the scripts as the **root user**.

##Prerequisites
-Raspberry Pi 5
-Internet connection for downloading dependencies (Data Usage ~10-12GB)
-You will need a Linux Physical machine or VM **at least 8GB of RAM or use SWAP file**
-Basic understanding of Kali Linux and Raspberry Pi