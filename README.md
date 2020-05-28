# Evirboz Minecraft Server

    docker run -d -v $(pwd):/home/minecraft



    java -Xmns16384M -Xmnx26215M -Xgc:concurrentScavenge -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:scvNoAdaptiveTenure -Xdisableexplicitgc -Xtune:virtualized -Xms32G -Xmx32G -jar forge-1.12.2-14.23.5.2854.jar --noconsole


# Firewall

    iptables -A INPUT -p tcp --dport 25565 -m state --state NEW -j ACCEPT
