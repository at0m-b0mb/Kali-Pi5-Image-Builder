# Kali Pi5 Image Builder

Welcome to the Kali Pi5 Image Builder repository! This script automates the creation of a customized Kali Linux image for Raspberry Pi 5 using the latest Arm build scripts provided by Kali Linux.

## Scripts

### Script 1: CLI Version
```bash
#!/bin/bash
git clone https://gitlab.com/kalilinux/build-scripts/kali-arm
cd kali-arm/
cat << "EOF"

             ,----------------,              ,---------,
        ,-----------------------,          ,"        ,"|
      ,"                      ,"|        ,"        ,"  |
     +-----------------------+  |      ,"        ,"    |
     |  .-----------------.  |  |     +---------+      |
     |  |                 |  |  |     | -==----'|      |
     |  |  HackProKP!     |  |  |     |         |      |
     |  |  Hack The World |  |  |/----|`---=    |      |
     |  |  C:\>_          |  |  |   ,/|==== ooo |      ;
     |  |                 |  |  |  // |(((( [33]|    ,"
     |  `-----------------'  |," .;'| |((((     |  ,"
     +-----------------------+  ;;  | |         |,"     
        /_)______________(_/  //'   | +---------+
   ___________________________/___  `,
  /  oooooooooooooooo  .o.  oooo /,   \,"-----------
 / ==ooooooooooooooo==.o.  ooo= //   ,`\--{)B     ,"
/_==__==========__==_ooo__ooo=_/'   /___________,"
`-----------------------------'
GitHub: https://github.com/at0m-b0mb/Kali-Pi5-Image-Builder/    
HackProKP - Kailash Parshad

EOF
# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Ask the user if they watched a YouTube tutorial
read -p "Do you want to watch an Official YouTube tutorial for help? (yes/no): " watched_tutorial

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

### Script 1: CLI Version
- Runs in the command line for users who prefer a text-based interface.
- Execute the script:
```shell
git clone https://github.com/at0m-b0mb/Kali-Pi5-Image-Builder.git
cd Kali-Pi5-Image-Builder
dos2unix Kali-Pi5-Image-Builder.sh
sudo bash Kali-Pi5-Image-Builder.sh
```
**Note**: Ensure that you have the necessary permissions to execute the scripts with sudo. If not, run the scripts as the root user.

## Prerequisites
- Raspberry Pi 5
- Internet connection for downloading dependencies
- You will need a Linux Physical machine or VM **at least 8GB of RAM or use SWAP file**
- Basic understanding of Kali Linux and Raspberry Pi

## Building :
- Depending on your system hardware & network connectivity, will depend on how long it will take to build (4 core CPU, 8GB RAM, SSD inside a VM takes using a local repo about 100 minutes per script)

- On x64 systems, after the script finishes running, you will have an image file located in `~/kali-arm/images/` called `kali-linux-2023.3-rpi-armhf.img.xz`

- On x86 systems, as they do not have enough RAM to compress the image, after the script finishes running, you will have an image file located in `~/kali-arm/images/` called `kali-linux-2023.3-rpi-armhf.img`

  - Should you want to try and shrink the file to make it easier to distribute, you will need to use your own preferred compression.

