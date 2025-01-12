
# This is easier for now
source ./venv/bin/activate

# Verify we're in the virtual environment
echo "Using Python from: $(which python)"

# Install the package from GitHub
echo "Installing JitStreamer..."
pip install git+https://github.com/jawshoeadan/JitStreamer.git

echo "Installation complete!"
