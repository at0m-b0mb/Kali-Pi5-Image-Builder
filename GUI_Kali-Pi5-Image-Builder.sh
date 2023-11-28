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
