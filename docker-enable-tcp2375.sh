#!/bin/bash

# Create the /etc/docker directory if it doesn't exist
sudo mkdir -p /etc/docker

# Create the daemon.json file with the specified configuration
cat <<EOF > /etc/docker/daemon.json
{
  "hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]
}
EOF

# Create the systemd override directory if it doesn't exist
sudo mkdir -p /etc/systemd/system/docker.service.d

# Create the override.conf file with the specified configuration
cat <<EOF > /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
EOF

# Reload the systemd daemon
sudo systemctl daemon-reload

# Restart the Docker service
sudo systemctl restart docker.service

echo "Docker configuration updated and service restarted."
