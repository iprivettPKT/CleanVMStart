#!/bin/bash

sudo apt update -yy
sudo apt upgrade -yy

# Create directories
echo "[+] Setting up directories"
mkdir ~/isaac
cd ~/isaac
mkdir tools scans
cd tools
echo "[+] Directories set up successfully. Currently in $(pwd)."

# Installing git
echo "[+] Installing git"
sudo apt-get install git -yy

# Installing vim
echo "[+] Installing vim"
sudo apt-get install vim -yy

# Installing tmux
echo "[+] Installing tmux"
sudo apt-get install tmux -yy

# Installing other tools
echo "[+] Installing requested tools"
sudo apt install nikto sslscan seclists gobuster apache2 dnsutils dsniff responder certipy enum4linux gcc -yy

# Installing Caido
echo "[+] Installing Caido"
sudo wget https://storage.googleapis.com/caido-releases/v0.29.2/caido-linux-v0.29.2-2e9984b7.tar.gz
tar -xzf caido-linux-v0.29.2-2e9984b7.tar.gz 

# Installing Python libraries
echo "[+] Installing Python libraries"
python3 -m pip install Scapy
python3 -m pip install requests
python3 -m pip install impacket
python3 -m pip install pwntools
python3 -m pip install Cryptography
python3 -m pip install python-nmap
python3 -m pip install Faker
python3 -m pip install Twisted
python3 -m pip install pylibnet
python3 -m pip install paramiko
python3 -m pip install RawSocketpy
python3 -m pip install pandas
python3 -m pip install beautifulsoup4

# Cloning tools from GitHub
echo "[+] Cloning tools from GitHub"
sudo git clone git@github.com/topotam/PetitPotam.git

sudo git clone git@github.com/forta/impacket.git

sudo git clone git@github.com/iprivettPKT/cookie-scan.git

python3 -m pip install playwright

python3 -m playwright install

touch domains.txt

echo google.com >> domains.txt

# Configuring Tinyproxy
CONFIG_FILE="/etc/tinyproxy/tinyproxy.conf"
if [ -f "$CONFIG_FILE" ]; then
    sudo sed -i '/^#Allow [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$/s/^#//g' $CONFIG_FILE
    echo "[+] Tinyproxy configuration updated."
else
    echo "[-] Tinyproxy configuration file not found. Manual configuration required."
fi

# Restarting Tinyproxy service
sudo systemctl stop tinyproxy
sudo systemctl start tinyproxy
echo "[+] Tinyproxy service restarted."

# Starting Apache service
sudo systemctl start apache2
echo "[+] Apache2 service started."

tmux

echo "[+] Script completed!"
