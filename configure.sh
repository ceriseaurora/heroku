#!/bin/sh

# Download and install xray
mkdir /tmp/xray
curl -L -H "Cache-Control: no-cache" -o /tmp/xray/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip /tmp/xray/xray.zip -d /tmp/xray
install -m 755 /tmp/xray/xray /usr/local/bin/xray

# Remove temporary directory
rm -rf /tmp/xray
# xray new configuration
install -d /usr/local/etc/xray
cat << EOF > /usr/local/etc/xray/config.json
{
    "log": {
        "loglevel": "none"
    },
    "dns": {
        "servers": [
          "8.8.8.8",
          "8.8.4.4",
          "localhost"
        ],
    "inbounds": [
        {
            "port": ${PORT},
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                      "id": "${id}",
                      "alterId": 0
                    }
                  ]
            }
          },
        {
            "port": ${PORT},
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                     "password": "${password}",
                      "flow": "xtls-rprx-direct"
                    }
                  ]
            }
        },
        {
            "port": ${PORT},
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                      "id": "5783a3e7-e373-51cd-8642-c83782b807c5",
                      "level": 0,
                      "flow": "xtls-rprx-direct"
                    }
                  ],
                  "decryption": "none"
            }
        }
    ],
        "transport": {
          "wsSettings": {
            "path": ""
          },
          "quicSettings": {
            "security": "none",
            "header": {
                "type": "none"
              }
          },
          "grpcSettings": {
            "serviceName": ""
          }
        },
    "outbounds": [
        {
            "protocol": "Freedom"
        }
    ]
}
}
EOF

# Run xray
/usr/local/bin/xray -config /usr/local/etc/xray/config.json
sysctl -p
