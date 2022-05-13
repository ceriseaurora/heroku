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
    "inbounds": [
        {
            "port": ${PORT},
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                      "id": "${id}",
                      "alterId": 0,
                      "email": "love@xray.com"
                    }
                  ]
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "${path}"
                }
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
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "${path}"
                }
          }
        }
    ],
    "outbounds": [
        {
            "protocol": "Freedom"
        }
    ]
}
EOF

# Run xray
/usr/local/bin/xray -config /usr/local/etc/xray/config.json
sysctl -p
