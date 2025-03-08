#!/bin/bash

kitty --hold bash -c '
    ssid=$(nmcli -g SSID device wifi list | fzf)

    echo -n "Password: "
    read -s password
    
    echo -e "\n\nConnecting to $ssid...\n"
    # Connect to Wi-Fi
    nmcli device wifi connect "$ssid" password "$password"
'
