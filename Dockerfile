# FlamePaper Official Dockerfile by 2LStudios.
# Based on https://github.com/itzg/docker-bungeecord

# Using java-8 as base.
ARG BASE_IMAGE=eclipse-temurin:8
FROM ${BASE_IMAGE}

VOLUME ["/server"]
WORKDIR /server

# Download dependencies
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
    sudo \
    net-tools \
    curl \
    tzdata \
    nano \
    unzip \
    ttf-dejavu \
    wget \
    && apt-get clean

# Set default user and group
RUN addgroup --gid 1000 flamepaper \
  && adduser --system --shell /bin/false --uid 1000 --ingroup flamepaper --home /server flamepaper

# Default env variables
ENV RESTART=false MEMORY=1G PORT=25565 
EXPOSE $PORT

# Command to run in the container
CMD ["/usr/bin/run-flamepaper.sh"]

COPY *.sh /usr/bin/