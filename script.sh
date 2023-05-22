#!/bin/bash

echo "=======Setting up the apt repository======="

# 1) Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

# 2) Add Docker’s official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg


# 3) the following command to set up the repository:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


echo "=======Installling Docker Engine======="

# 1) Update the apt package index:
sudo apt-get update

# 2) Install Docker Engine, containerd, and Docker Compose.
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=======Starting a PostgreSQL instance======="

sudo docker pull postgres
sudo docker run -d \
    --name postgresDB \
    -e POSTGRES_PASSWORD=admin \
    -v postgresData:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres