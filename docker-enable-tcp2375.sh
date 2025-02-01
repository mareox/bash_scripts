#!/bin/bash

# Create the /etc/docker directory if it doesn't exist
mkdir -p /etc/docker

# Create the daemon.json file with the specified configuration
cat <<EOF > /etc/docker/daemon.json
{
  "hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]
}
EOF

# Create the systemd override directory if it doesn't exist
mkdir -p /etc/systemd/system/docker.service.d

# Create the override.conf file with the specified configuration
cat <<EOF > /etc/systemd/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
EOF

# Reload the systemd daemon
systemctl daemon-reload

# Restart the Docker service
systemctl restart docker.service

echo "Docker configuration updated and service restarted."
