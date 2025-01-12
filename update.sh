# #!/bin/bash
# # Function to check a package and return update status
# check_package() {
#     local package_name=$1
#     local repo_url=$2
#     local egg_name=$3
#     local needs_update=0
    
#     echo "Checking $package_name..."
    
#     # Get the installed version (only the first line)
#     installed_version=$(pip show $package_name | grep Version | cut -d' ' -f2 | head -n 1)
#     echo "Installed version: $installed_version"
    
#     # Extract the commit hash from the version, accounting for the 'g' prefix
#     installed_commit=$(echo $installed_version | grep -oE 'g?[a-f0-9]{7,}$' | sed 's/^g//')
#     echo "Installed commit: $installed_commit"
    
#     # Get the latest commit SHA from the repository
#     latest_commit=$(git ls-remote $repo_url HEAD | cut -f1)
#     echo "Latest commit: ${latest_commit:0:7}"
    
#     if [ -z "$installed_commit" ]; then
#         echo "Unable to determine installed commit hash for $package_name."
#         needs_update=1
#     elif [ "${latest_commit:0:${#installed_commit}}" != "$installed_commit" ]; then
#         echo "New version available for $package_name."
#         needs_update=1
#     else
#         echo "$package_name is up to date."
#         needs_update=0
#     fi
    
#     return $needs_update
# }

# # Activate the virtual environment
# echo "Activating virtual environment..."
# source ./venv/bin/activate

# # Initialize update flag
# needs_update=0

# # Check JitStreamer
# check_package "JitStreamer" "https://github.com/jawshoeadan/JitStreamer.git" "JitStreamer"
# if [ $? -eq 1 ]; then
#     needs_update=1
# fi

# # Check pymobiledevice3
# check_package "pymobiledevice3" "https://github.com/jawshoeadan/pymobiledevice3.git" "pymobiledevice3"
# if [ $? -eq 1 ]; then
#     needs_update=1
# fi

# # If either package needed an update, install latest JitStreamer
# if [ $needs_update -eq 1 ]; then
#     echo "Updates needed - installing latest JitStreamer..."
#     pip install --upgrade "git+https://github.com/jawshoeadan/JitStreamer.git#egg=JitStreamer"
# fi

# echo "Updating Tailscale..."
# sudo tailscale update
# echo "All updates completed."

# This is easier for now
source ./venv/bin/activate

# Verify we're in the virtual environment
echo "Using Python from: $(which python)"

# Install the package from GitHub
echo "Installing JitStreamer..."
pip install git+https://github.com/jawshoeadan/JitStreamer.git

echo "Installation complete!"