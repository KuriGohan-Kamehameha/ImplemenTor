#!/bin/bash
# Update system and install needed package(s)
sudo apt-get update -y && sudo apt-get full-upgrade -y && sudo apt-get install tor -y

# Configure Tor hidden service for port 80 (HTTP)
sudo bash -c 'cat <<EOF >> /etc/tor/torrc
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 127.0.0.1:80
EOF'

# Restart Tor to apply changes
sudo systemctl restart tor

# Retrieve and display the generated Tor onion address
echo "Waiting for Tor to establish the hidden service..."
sleep 10  # Wait for Tor to establish the hidden service
onion_address=$(sudo cat /var/lib/tor/hidden_service/hostname)
echo "Your Tor onion address is: $onion_address"

# Provide instructions for accessing the Tor onion service
echo "You can now access your Tor onion service at:"
echo "http://$onion_address/"
