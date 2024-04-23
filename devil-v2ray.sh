#!/bin/sh

# Remove existing config file if exists
rm -rf /etc/xray/config.json

# Write new config file with corrected TLS settings
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
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "see.sightcall.com",
          "alpn": ["http/1.1"]
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
