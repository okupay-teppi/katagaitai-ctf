#!/bin/sh -eux

echo "[+] apt"
sudo apt update
sudo apt install -y gdb-multiarch binutils gcc file python3-pip ruby-dev git

echo "[+] pip3"
. ~/venv/bin/activate
pip3 install crccheck unicorn capstone ropper keystone-engine tqdm

echo "[+] install seccomp-tools, one_gadget"
if [ "x$(which seccomp-tools)" = "x" ]; then
    gem install seccomp-tools
fi

if [ "x$(which one_gadget)" = "x" ]; then
    gem install one_gadget
fi

echo "[+] install rp++"
if [ "x$(uname -m)" = "xx86_64" ]; then
    if [ "x$(which rp-lin)" = "x" ] && [ ! -e /usr/local/bin/rp-lin ]; then
        wget -q https://github.com/0vercl0k/rp/releases/download/v2.1.3/rp-lin-clang.zip -P /tmp --no-check-certificate
        unzip /tmp/rp-lin-clang.zip -d /usr/local/bin/
        chmod +x /usr/local/bin/rp-lin
        rm /tmp/rp-lin-clang.zip
    fi
fi

echo "[+] install vmlinux-to-elf"
if [ "x$(which vmlinux-to-elf)" = "x" ] && [ ! -e /usr/local/bin/vmlinux-to-elf ]; then
    pip3 install --upgrade lz4 zstandard git+https://github.com/clubby789/python-lzo@b4e39df
    pip3 install --upgrade git+https://github.com/marin-m/vmlinux-to-elf
fi

echo "[+] download gef"
GEF_PATH="$HOME/.gdbinit-gef.py"
if [ -e "$GEF_PATH" ]; then
    echo "[-] $GEF_PATH already exists. Please delete or rename."
    echo "[-] INSTALLATION FAILED"
    exit 1
else
    wget -q https://raw.githubusercontent.com/bata24/gef/dev/gef.py -O "$GEF_PATH" --no-check-certificate
fi

echo "[+] setup gef"
GDBINIT_PATH="$HOME/.gdbinit"
STARTUP_COMMAND="source $GEF_PATH"
if [ ! -e "$GDBINIT_PATH" ] || [ "x$(grep "$STARTUP_COMMAND" "$GDBINIT_PATH")" = "x" ]; then
    echo "$STARTUP_COMMAND" >> "$GDBINIT_PATH"
fi

echo "[+] INSTALLATION SUCCESSFUL"
exit 0
