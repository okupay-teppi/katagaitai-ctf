#!/bin/bash

# 必要なパッケージのインストール
sudo apt update
sudo apt install -y python3 gdb python3-pip python3-venv openjdk-21-jdk

# Ghidraのインストール
echo "[*]install ghidra"
GHIDRA_URL="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.2.1_build/ghidra_11.2.1_PUBLIC_20241105.zip"
wget $GHIDRA_URL -O ghidra.zip --no-check-certificate
unzip ghidra.zip -d ~
rm ghidra.zip
echo 'export PATH="$PATH:$HOME/ghidra_11.2.1_PUBLIC"' >> ~/.bashrc

# Python環境の設定
echo "[*] Setup Python virtual environment"
python3 -m venv ~/venv
. ~/venv/bin/activate

# pwntoolsのインストール
echo "[*] install pwntools"
pip3 install pwntools

# ROPgadgetのインストール
echo "[*] install ROPgadget"
pip3 install ROPgadget

# PyCryptodome
pip3 install pycryptodome

# Gefのインストール
echo "[*] install GEF"
wget -qO- https://github.com/okupay-teppi/katagaitai-ctf/blob/main/install_gef.sh --no-check-certificate | sh

deactivate

echo "[*] Done!"
