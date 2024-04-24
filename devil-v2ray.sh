#!/bin/sh

# Config v2ray (assumes you're using VLESS)
rm -rf /etc/xray/config.json
cat << EOF > /etc/xray/config.json
{
  "inbounds": [
    {
      "port": $PORT, 
      "protocol": "vless",
      "settings": {
        "decryption": "none",
        "clients": [
          {
            "id": "$UUID", 
            "flow": "xtls-rprx-direct"  # Enable XTLS for CloudFlare proxying
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "xtls",  # Activate XTLS
        "xtlsSettings": {
          "serverName": "see.sightcall.com"  # Your bug host
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIP"  # May be needed for Heroku
      }
    }
  ]
}
EOF

# Run v2ray server
xray -c /etc/xray/config.json
