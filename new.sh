#!/bin/bash


# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "This system want super user privilage"
  
  exit
fi

#update package lists
echo "Updating packaging lists.... "
apt-get update
clear

#upgrading installed packages
echo "upgrading installing packages......."
apt-get upgrade
clear 

#installing nmap
echo "installing nmap....."
apt-get install nmap
clear

#installing metasploit
echo "installing metasploit....."
apt-get install metasploit-framework
clear

echo "preparing for scanning......"
read -p "Enter the IP adress of the target devices:  " tar_ip 

#Scan launching user confermation
read -p "Are you sure you want to proceed? (y/n): " answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Proceeding....."


#scanning the target device
echo "scanning the target device....."
nmap -sS -sV -O $tar_ip

#scanning the target device for check vulnerabilities
echo "scanning the target device for check vulnerabilities....."
nmap --script vuln $tar_ip

#opening terminal
echo "opening terminal....."
gnome-terminal
konsole
xterm

#opening metasploit 
echo "opening metasploit....."
msfconsole

else
    echo "Exiting....."
    exit 1
fi
