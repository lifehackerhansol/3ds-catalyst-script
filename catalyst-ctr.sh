#!/bin/bash
########################################
# THIS WAS STOLEN FROM MY NX SCRIPT!!  #
########################################

###################
# Fucking kill me #
###################
export script_start=`pwd`

########
# Luma #
########
echo "Downloading Luma"
curl -sLq https://api.github.com/repos/LumaTeam/Luma3DS/releases/latest | jq -r '.assets[0].browser_download_url' | wget -qi -

#################
# Homebrew apps #
#################
echo "Downloading Anemone"
curl -sLq https://api.github.com/repos/astronautlevel2/Anemone3DS/releases/latest | jq -r '.assets[1].browser_download_url' | wget -qi -

echo "Downloading Universal Updater"
curl -sLq https://api.github.com/repos/Universal-Team/Universal-Updater/releases/latest | jq -r '.assets[1].browser_download_url' | wget -qi -

echo "Downloading GodMode9"
curl -sLq https://api.github.com/repos/d0k3/GodMode9/releases/latest | jq -r '.assets[].browser_download_url' | wget -qi -

echo "Downloading unSAFE_MODE"
wget -q "https://github.com/zoogie/unSAFE_MODE/releases/download/v1.3/RELEASE_v1.3.zip"

echo "Downloading FBI"
wget -q "https://github.com/Steveice10/FBI/releases/download/2.6.1/FBI.cia"
wget -q "https://github.com/Steveice10/FBI/releases/download/2.6.1/FBI.3dsx"

echo "Downloading universal-otherapp"
wget -q "https://github.com/TuxSH/universal-otherapp/releases/download/v1.4.0/otherapp.bin"

echo "Downloading boot9strap"
wget -q "https://github.com/SciresM/boot9strap/releases/download/1.4/boot9strap-1.4.zip"

echo "Downloading SafeB9SInstaller"
wget -q "https://github.com/d0k3/SafeB9SInstaller/releases/download/v0.0.7/SafeB9SInstaller-20170605-122940.zip"

echo "Downloading Homebrew Launcher Wrapper"
wget -q "https://github.com/PabloMK7/homebrew_launcher_dummy/releases/download/v1.0/Homebrew_Launcher.cia"

echo "Downloading Checkpoint"
wget -q "https://github.com/FlagBrew/Checkpoint/releases/download/v3.7.4/Checkpoint.cia"

echo "Downloading frogminer_save"
wget -q "https://github.com/zoogie/Frogminer/releases/download/v1.0/Frogminer_save.zip"

echo "Downloading b9sTool"
wget -q "https://github.com/zoogie/b9sTool/releases/download/v6.1.1/release_6.1.1.zip"

echo "Downloading BannerBomb3"
wget -q "https://github.com/lifehackerhansol/Bannerbomb3/releases/download/v3.0-lhs2/bb3.bin"

echo "Downloading custom otherapp package"
wget -q "https://3ds.hacks.guide/assets/otherapps.zip"

echo "Downloading steelhax"
wget -q "https://3ds.hacks.guide/assets/steelhax-release.zip"

echo "Downloading super-skaterhax"
wget -q "https://github.com/zoogie/super-skaterhax/releases/download/v1.1/release_new3ds_v1.1.zip"

echo "Downloading frogtool"
wget -q "https://github.com/zoogie/Frogtool/releases/download/v2.3/Frogtool_v2.3.zip"

#####################
# make some folders #
#####################
echo "Creating directories for each catalyst"
mkdir -p {soundhax,usm,pichaxx,ntrboot,ssloth,safecerthax,super-skaterhax,steelhax,fredtool} # saves me the slightest bit of time later

echo "Creating common directory"
mkdir -p common/{3ds,cias,boot9strap,luma/payloads}

echo "Creating output dir"
mkdir out

####################
# Do the unzipping #
####################
echo "Do the unzipping"
unzip -q Luma3DSv*.zip;rm Luma3DSv*.zip
mkdir tmp;mv GodMode9*.zip tmp;cd tmp/;unzip -q *.zip;mv GodMode9.firm ..; mv -f gm9 ..;cd ..;rm -rf tmp
unzip -q boot9strap-1.4.zip;rm boot9strap-1.4.zip
mkdir tmp;mv SafeB9SInstaller*.zip tmp;cd tmp/;unzip -q *.zip;mv SafeB9SInstaller.bin ..;mv SafeB9SInstaller.firm ..;cd ..;rm -rf tmp
mkdir tmp;mv RELEASE_v1.3.zip tmp;cd tmp/;unzip -q RELEASE_v1.3.zip;mv -f slotTool ..;mv -f usm.bin ..;cd ..;rm -rf tmp
unzip -q Frogminer_save.zip;rm Frogminer_save.zip
mkdir tmp;mv release_6.1.1.zip tmp;cd tmp/;unzip -q *.zip;mv boot.nds ..;cd ..;rm -rf tmp
mkdir otherapps;unzip -q otherapps.zip -d otherapps;rm otherapps.zip
mkdir skaterhax-release;unzip -q release_new3ds_v1.1.zip -d skaterhax-release;rm release_new3ds_v1.1.zip
mkdir steelhax-release;unzip -q steelhax-release.zip -d steelhax-release;rm steelhax-release/*.txt;rm steelhax-release.zip
unzip -q Frogtool_v2.3.zip;rm *.txt;rm Frogtool_v2.3.zip

#########################
# extract common things #
#########################
echo "Common directories"
mv *.cia common/cias
mv FBI.3dsx common/3ds/FBI.3dsx # I can't automate .3dsx batch copies, but also there's only one 3dsx so whatever
mv boot.3dsx common/boot.3dsx
mv boot.firm common/boot.firm
mv GodMode9.firm common/luma/payloads
mv -f gm9 common/gm9
mv boot9strap.* common/boot9strap

################
# yay soundhax #
################
echo "Putting soundhax related files in correct locations"
cp -r common/* soundhax
cp otherapp.bin soundhax
cp SafeB9SInstaller.bin soundhax
cd soundhax
zip -r soundhax.zip * 
mv soundhax.zip ../out
cd ..
rm -rf soundhax

###############
# safecerthax #
###############
echo "Putting safecerthax related files in correct locations"
cp -r common/* safecerthax
cp SafeB9SInstaller.bin safecerthax
cd safecerthax
zip -r $PWD.zip * 
mv $PWD.zip ../out
cd ..
rm -rf safecerthax

##############################
# browserhax just won't die #
##############################
echo "Putting SSLoth-Browser related files in correct locations"
cp -r common/* ssloth
mv otherapp.bin ssloth/arm11code.bin
cp SafeB9SInstaller.bin ssloth
cd ssloth
zip -r ssloth.zip * 
mv ssloth.zip ../out
cd ..
rm -rf ssloth

####################
# methax? pichaxx? #
####################
echo "Putting pichaxx related files in correct locations"
cp -r common/* pichaxx
cp -r slotTool pichaxx/3ds/slotTool
cp -r otherapps pichaxx/otherapps
cp Frogtool.3dsx pichaxx/3ds/
cp usm.bin pichaxx/usm.bin
cp SafeB9SInstaller.bin pichaxx
echo "!!! You must copy the corresponding *.bin file from the otherapps folder for your console to the SD root,
and rename it to otherapp.bin.

The exploit will fail without it. !!!" > pichaxx/readme.txt
cd pichaxx
zip -r pichaxx.zip * 
mv pichaxx.zip ../out
cd ..
rm -rf pichaxx

############
# steelhax #
############
echo "Putting steelhax related files in correct locations"
cp -r common/* steelhax
mv slotTool steelhax/3ds/slotTool
mv otherapps steelhax/otherapps
cp Frogtool.3dsx steelhax/3ds/
cp usm.bin steelhax/usm.bin
cp SafeB9SInstaller.bin steelhax
mv steelhax-release steelhax/steelhax
echo "!!! You must copy the corresponding *.bin file from the otherapps folder for your console to the SD root,
and rename it to otherapp.bin.

The exploit will fail without it. !!!" > steelhax/readme.txt
cd steelhax
zip -r $PWD.zip * 
mv $PWD.zip ../out
cd ..
rm -rf steelhax

################################
# YABH: yet another browserhax #
################################
echo "Putting super-skaterhax related files in correct locations"
cp -r common/* super-skaterhax
mv skaterhax-release super-skaterhax/super-skaterhax
mv Frogtool.3dsx super-skaterhax/3ds/
cp usm.bin super-skaterhax/usm.bin
cp SafeB9SInstaller.bin super-skaterhax
echo "!!! You must all files from the folder for your console's region/version in the super-skaterhax folder to the SD root.

The exploit will fail without it. !!!" > super-skaterhax/readme.txt
cd super-skaterhax
zip -r $PWD.zip * 
mv $PWD.zip ../out
cd ..
rm -rf super-skaterhax

################################
# unsafe mode is actually safe #
################################
echo "Putting USM related files in correct locations"
cp -r common/* usm
cp bb3.bin usm
mv usm.bin usm
mv SafeB9SInstaller.bin usm
cd usm
zip -r usm.zip * 
mv usm.zip ../out
cd ..
rm -rf usm

###################
# fwedtool is old #
###################
echo "Putting fredtool related files in correct locations"
cp -r common/* fredtool
mv bb3.bin fredtool
mv private fredtool/
mv boot.nds fredtool
cd fredtool
zip -r fredtool.zip * 
mv fredtool.zip ../out
cd ..
rm -rf fredtool

##################################
# pay 20USD for CFW with ntrboot #
##################################
echo "Putting ntrboot related files in correct locations"
mv -f common/* ntrboot
rm -rf common # cleanup
mv ntrboot/boot.firm ntrboot/luma/boot.firm
mv SafeB9SInstaller.firm ntrboot/boot.firm
echo "!!! boot.firm is the SafeB9Sinstaller. Once you have used it to install b9s successfully, you should delete it, and move boot.firm from the /luma folder onto the root folder. 

Your device will only boot to SafeB9Sinstaller until you do this. !!!" > ntrboot/readme.txt
cd ntrboot
zip -r ntrboot.zip * 
mv ntrboot.zip ../out
cd ..
rm -rf ntrboot

###########
# md5sums #
###########
for cum in out/*
do
    md5sum "$cum" > "$cum.md5"
done

###########
# Credits #
###########
# 46620 for putting this on github
#
# and the following people that 46620 credits:
#
# One liner to download latest release: https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8#gistcomment-2724872
# My friend Logan for being in voice with my while not doing his school work
# Will Stetson for making the music I am listening to while doing this https://www.youtube.com/watch?v=8daZtdrFmBY
# My friend Brandon's DS that had a broken start button making it so I had to use browserhax and add the second zip file
# My boyfriend for letting me use him as a pillow a few times a week to keep me alive
