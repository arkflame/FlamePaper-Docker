# FlameCord Official Dockerfile by 2LStudios.
# Based on https://github.com/itzg/docker-bungeecord

# Using java-17 as base.
ARG BASE_IMAGE=eclipse-temurin:17
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
RUN addgroup --gid 1000 flamecord \
  && adduser --system --shell /bin/false --uid 1000 --ingroup flamecord --home /server flamecord

# Default env variables
ENV RESTART=false MEMORY=512m PORT=25577 
EXPOSE $PORT

# Command to run in the container
CMD ["/usr/bin/run-flamecord.sh"]

COPY *.sh /usr/bin/