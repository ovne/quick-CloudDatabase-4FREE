#!/bin/bash

# =======Set up apt repository & install Docker engine=======
# source: https://docs.docker.com/engine/install/debian/

sudo apt-get update

sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installling Docker Engine
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# =======Starting a PostgreSQL instance======="
sudo docker pull postgres
sudo docker run -d \
    --name postgresDB \
    -e POSTGRES_PASSWORD=admin \
    -v postgresData:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres