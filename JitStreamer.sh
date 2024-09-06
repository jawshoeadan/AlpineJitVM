#!/bin/sh

# Display welcome message with additional information
echo "Welcome to JitStreamer!"
echo "Starting the server. This might take a few seconds..."

# Run tailscale up
tailscale up

# Get and display the Tailscale IPv4 address
TAILSCALE_IP=$(tailscale ip -4)
echo "This will be your server IP: $TAILSCALE_IP"

# Run usbmuxd
usbmuxd

# Activate the virtual environment
. ./venv/bin/activate

# Run the JitStreamer binary
/root/venv/bin/JitStreamer
