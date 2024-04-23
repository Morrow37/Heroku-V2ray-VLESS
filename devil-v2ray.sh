#!/bin/sh

# Config v2ray

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
            "id": "$UUID" 
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls", 
        "wsSettings": {
          "headers": {
            "Host": "see.sightcall.com" 
          },
          "path": "/" 
        }
      }
    }
  ],
  "outbounds": [ 
    {
      "protocol": "freedom"
    }
  ] 
}
EOF

# Run v2ray server
xray -c /etc/xray/config.json
