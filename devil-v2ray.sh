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
            "flow": "xtls-rprx-vision"  # Use "xtls-rprx-reality" if needed
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "xtls",  
        "xtlsSettings": {
          "serverName": "see.sightcall.com"  
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIP"  
      }
    }
  ]
}
EOF

# Run v2ray server
xray -c /etc/xray/config.json 
