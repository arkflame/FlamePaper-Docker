#!/bin/bash
JAR="FlamePaper.jar"
URL="https://ci.2lstudios.dev/job/FlamePaper/lastSuccessfulBuild/artifact/FlamePaper-Server/target/FlamePaper.jar"

echo "====== FlamePaper Dockerized ======"
# echo "Memory: $MEMORY"
echo "Restart on end: $RESTART"
echo "==============================+===="

[[ ! -f "$JAR" ]] && echo "$JAR file not exist, downloading from CI..." && wget "$URL"

while true
do
    java -XX:=UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -jar ${JAR} nogui --noconsole
    if [ "$RESTART" = "true" ]; then
        echo "Server stopped, restarting instance in 3 seconds..."
        sleep 3
    else
        echo "Server stopped, docker container is terminated."
        exit
    fi
done
