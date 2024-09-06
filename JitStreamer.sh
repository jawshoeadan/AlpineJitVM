#!/bin/sh

# Display welcome message
echo "Welcome to JitStreamer!"

# Run tailscale up and let the user authenticate if needed
tailscale up

# Check if tailscale authentication was successful
if [ $? -ne 0 ]; then
    echo "Tailscale authentication failed. Please try again."
    exit 1
fi

# Activate the virtual environment
. ./venv/bin/activate

# Check if venv activation was successful
if [ $? -ne 0 ]; then
    echo "Failed to activate virtual environment. Please check if it exists at ./venv/bin/activate"
    exit 1
fi

# Run the JitStreamer binary
/root/venv/bin/JitStreamer

# Check if JitStreamer execution was successful
if [ $? -ne 0 ]; then
    echo "Failed to run JitStreamer. Please check if the binary exists at /root/venv/bin/JitStreamer"
    exit 1
fi
