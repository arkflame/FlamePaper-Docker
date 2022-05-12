#!/bin/bash
JAR="FlameCord.jar"
CFG="config.yml"
URL="https://ci.2lstudios.dev/job/FlameCord/lastSuccessfulBuild/artifact/FlameCord-Proxy/bootstrap/target/FlameCord.jar"

echo "====== FlameCord Dockerized ======"
echo "Memory: $MEMORY"
echo "Restart on end: $RESTART"
echo "=================================="

[[ ! -f "$JAR" ]] && echo "$JAR file not exist, downloading from CI..." && wget "$URL"

while true
do
    java -jar ${JAR} nogui -Xms$MEMORY -Xmx$MEMORY -XX:+UseG1GC -XX:+DisableExplicitGC
    if [ "$RESTART" = "true" ]; then
        echo "Server stopped, restarting instance in 3 seconds..."
        sleep 3
    else
        echo "Server stopped, docker container is terminated."
        exit
    fi
done
