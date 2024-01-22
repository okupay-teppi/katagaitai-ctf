#!/bin/bash

# 必要なパッケージのインストール
sudo apt update
sudo apt install -y python3 gdb  python3-pip openjdk-19-jdk

# Ghidraのインストール
# GHIDRA_URL="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.0_build/ghidra_11.0_PUBLIC_20231222.zip"
# wget $GHIDRA_URL -O ghidra.zip
# unzip ghidra.zip -d ~
# rm ghidra.zip
# echo 'export PATH="$PATH:$HOME/ghidra_11.0_PUBLIC"' >> ~/.bashrc

# APKToolのインストール
wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O /tmp/apktool
wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.5.0.jar -O /tmp/apktool.jar
sudo mv /tmp/apktool /usr/local/bin/
sudo mv /tmp/apktool.jar /usr/local/bin/apktool.jar
sudo chmod +x /usr/local/bin/apktool
sudo chmod +x /usr/local/bin/apktool.jar

# JADXのインストール
wget https://github.com/skylot/jadx/releases/download/v1.2.0/jadx-1.2.0.zip -O jadx.zip
unzip jadx.zip -d ~
rm jadx.zip
echo 'export PATH="$PATH:$HOME/jadx/bin"' >> ~/.bashrc

# pwntools
pip3 install pwntools

# ROPgadget
pip3 install ROPgadget

# Gef
sudo su -
wget -q https://raw.githubusercontent.com/bata24/gef/dev/install.sh -O- | sh

# PyCryptodome
pip3 install pycryptodome

# Gmpy2
sudo apt install -y libgmp-dev libmpfr-dev libmpc-dev
pip3 install gmpy2

# シェルの再読み込み
source ~/.bashrc

echo "[*] Done!"


