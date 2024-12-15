#!/bin/sh
printf "nameserver 127.0.0.11\nnameserver 8.8.4.4\nnameserver 223.5.5.5\n" > /etc/resolv.conf

CONFIG_FILE="/dashboard/data/config.yaml"
# Check if the file does not exist
if [ ! -f "$CONFIG_FILE" ]; then
    # Ensure the directory exists
    mkdir -p "$(dirname "$CONFIG_FILE")"
    # Create the file with the specified content
    cat << EOF > "$CONFIG_FILE"
debug: false
listenport: 8008
language: zh_CN
sitename: "Eddy Node Status"
installhost: 8100
tls: true
EOF
    echo "Config file created at $CONFIG_FILE"
else
    echo "Config file already exists at $CONFIG_FILE"
fi

exec /dashboard/app
