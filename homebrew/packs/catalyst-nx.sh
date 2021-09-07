#!/bin/bash
########################################
# THIS WILL NOT DOWNLOAD SIG PATCHES!  #
########################################

#######################
# Hekate & Atmosphere #
#######################
echo "Downloading Hekate"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/CTCaer/Hekate/releases/latest | jq -r '.assets[0].browser_download_url' | wget -i -
echo "Adding Hekate"
unzip hekate*.zip
rm hekate*.zip

echo "Downloading Atmosphere"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases | grep -wo "https.*.zip" | head -1 | wget -i -
echo "Adding Atmosphere"
unzip atmosphere*.zip
rm atmosphere*.zip

###############
# Guide Files #
###############
echo "Downloading hosts file"
mkdir -p atmosphere/hosts
wget -O atmosphere/hosts/emummc.txt "https://nh-server.github.io/switch-guide/files/emummc.txt"

echo "Downloading hekate files from meem" # Can be swapped out for guide files
wget -O bootloader/hekate_ipl.ini "https://dl.46620.moe/script-deps/switch/catalyst/hekate_ipl.ini" # tmp point towards my server while I wait for nh to update
wget -O bootloader/patches.ini "https://suchmememanyskill.github.io/guides/Img/patches.ini"

echo "Downloading boot logos" # Cause people need these for some fucking reason
wget "https://nh-server.github.io/switch-guide/files/bootlogos.zip"
unzip bootlogos.zip
rm bootlogos.zip

#################
# Homebrew Apps #
#################

echo "Adding nx-mtp"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/retronx-team/mtp-server-nx/releases/latest | jq -r '.assets[0].browser_download_url' | wget -O "switch/mtp-server-nx.nro" -i -

echo "Adding hb_appstore"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/fortheusers/hb-appstore/releases/latest | jq -r '.assets[2].browser_download_url' | wget -i -
unzip switch-extracttosd.zip;rm switch-extracttosd.zip

echo "Adding ftpd"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/mtheall/ftpd/releases/latest | jq -r '.assets[12].browser_download_url' | wget -O "switch/ftpd.nro" -i -

echo "Adding Goldleaf"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/XorTroll/Goldleaf/releases | grep -wo "https.*eaf.nro" | head -1 | wget -O "switch/Goldleaf.nro" -i -

echo "Adding Checkpoint"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/FlagBrew/Checkpoint/releases/latest | jq -r '.assets[2].browser_download_url' | wget -O "switch/Checkpoint.nro" -i -

echo "Adding NX-Shell"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/joel16/NX-Shell/releases/latest | jq -r '.assets[].browser_download_url' | wget -O "switch/NX-Shell.nro" -i -

echo "Adding NXThemeInstaller"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/exelix11/SwitchThemeInjector/releases/latest | jq -r '.assets[0].browser_download_url' | wget -O "switch/NXThemesInstaller.nro" -i -

echo "Adding nxdumptool"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/DarkMatterCore/nxdumptool/releases/latest | jq -r '.assets[].browser_download_url' | wget -O "switch/nxdumptool.nro" -i -

echo "Adding 90dns tester"
wget -O switch/Switch_90DNS_tester.nro "https://github.com/meganukebmp/Switch_90DNS_tester/releases/download/v1.0.3/Switch_90DNS_tester.nro"

################
# Payload Shit #
################

echo "Adding Lockpick_RCM" # This is the lockpicking lawyer
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/shchmue/Lockpick_RCM/releases/latest | jq -r '.assets[].browser_download_url' | wget -O "bootloader/payloads/Lockpick_RCM.bin" -i -

echo "Adding TegraExplorer" 
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/suchmememanyskill/TegraExplorer/releases/latest | jq -r '.assets[].browser_download_url' | wget -O "bootloader/payloads/TegraExplorer.bin" -i -

echo "Adding fusee payload"
curl -sL -H "Authorization: token $ghtoken" https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases | grep -wo "https.*.bin" | head -1 | wget -O "bootloader/payloads/fusee.bin" -i -

echo "Add Hekate to payloads"
cp hekate*.bin bootloader/payloads/hekate.bin

echo "Make Hekate reboot_payload"
mv hekate*.bin atmosphere/reboot_payload.bin

#############
# Frii logo #
#############
# echo Adding bootlogo
# update 2021-09-06, ams 1.0 made this section not needed and as I am currently fixing this script before nh says anything, I am removing this until notified
#wget -O bootloader/bootlogo.bmp "https://46620.moe/bootlogo.bmp"

###########
# Archive #
###########
echo "Create zip archive"
7z a -tzip "out/latest.zip" *
cd out
md5sum "latest.zip" > "latest.zip.md5"

###########
# Credits #
###########
# One liner to download latest release: https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8#gistcomment-2724872
# PhazonicRidley for telling me I should set this back up: https://gitlab.com/PhazonicRidley
# Nintendo Homebrew for using this as their catalyst pack: https://discord.gg/C29hYvh
# Cruzmatt22 for being in voice chat: https://images-na.ssl-images-amazon.com/images/I/71hcpuNp7gL._SY445_.jpg
# Windows 10 for being shit and somehow causing my internet to constantly go down: https://www.microsoft.com/en-us/
# My computer for constantly BSoD'ing cause I have some memory issues while I try to not make this script bad
# My brain for figuring out "Oh hey lemme set the path in the actual one liner"
# ams for updating to 1.0 finally and making me rework some of my script.
# My boyfriend for letting me use him as a pillow a few times a week to keep me alive
