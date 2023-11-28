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

#Installs all required dependencies.
./common.d/build_deps.sh 
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
