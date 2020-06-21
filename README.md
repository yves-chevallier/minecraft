# Evirboz Minecraft Server

## Download server

    mkdir -p /opt
    git clone https://github.com/yves-chevallier/minecraft.git /opt/minecraft
    cp /opt/minecraft/.env.example /opt/minecraft/.env

## Install service

    ln -s /opt/minecraft/minecraft.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl enable minecraft

## Start server

    systemctl start minecraft

## Configure Firewall

    iptables -A INPUT -p tcp --dport 25565 -m state --state NEW -j ACCEPT
    iptables -A INPUT -p tcp --dport 25575 -m state --state NEW -j ACCEPT
