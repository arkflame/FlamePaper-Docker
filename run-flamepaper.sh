#!/bin/bash
JAR="FlamePaper.jar"
URL="https://ci.2lstudios.dev/job/FlamePaper/lastSuccessfulBuild/artifact/FlamePaper-Server/target/FlamePaper.jar"

echo "====== FlamePaper Dockerized ======"
echo "Memory: $MEMORY"
echo "Restart on end: $RESTART"
echo "==============================+===="

[[ ! -f "$JAR" ]] && echo "$JAR file not exist, downloading from CI..." && wget "$URL"

while true
do
    java -Xms$MEMORY -Xmx$MEMORY -XX:+UseG1GC -XX:+DisableExplicitGC -jar ${JAR} nogui
    if [ "$RESTART" = "true" ]; then
        echo "Server stopped, restarting instance in 3 seconds..."
        sleep 3
    else
        echo "Server stopped, docker container is terminated."
        exit
    fi
done
