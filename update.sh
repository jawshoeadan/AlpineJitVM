#!/bin/bash
# Function to check a package and return update status
check_package() {
    local package_name=$1
    local repo_url=$2
    local egg_name=$3
    
    echo "Checking $package_name..."
    
    # Get the installed version (only the first line)
    installed_version=$(pip show $package_name | grep Version | cut -d' ' -f2 | head -n 1)
    echo "Installed version: $installed_version"
    
    # Extract the commit hash from the version, accounting for the 'g' prefix
    installed_commit=$(echo $installed_version | grep -oE 'g?[a-f0-9]{7,}$' | sed 's/^g//')
    echo "Installed commit: $installed_commit"
    
    # Get the latest commit SHA from the repository
    latest_commit=$(git ls-remote $repo_url HEAD | cut -f1)
    echo "Latest commit: ${latest_commit:0:7}"
    
    if [ -z "$installed_commit" ]; then
        echo "Unable to determine installed commit hash for $package_name."
        return 1
    elif [ "${latest_commit:0:${#installed_commit}}" != "$installed_commit" ]; then
        echo "New version available for $package_name."
        return 1
    else
        echo "$package_name is up to date."
        return 0
    fi
}

# Activate the virtual environment
echo "Activating virtual environment..."
source ./venv/bin/activate

# Check both packages first
jitstreamer_status=$(check_package "JitStreamer" "https://github.com/jawshoeadan/JitStreamer.git" "JitStreamer")
pymd3_status=$(check_package "pymobiledevice3" "https://github.com/jawshoeadan/pymobiledevice3.git" "pymobiledevice3")

# If either package needs an update, install latest JitStreamer
if [ $jitstreamer_status -eq 1 ] || [ $pymd3_status -eq 1 ]; then
    echo "Updates needed - installing latest JitStreamer..."
    pip install --upgrade "git+https://github.com/jawshoeadan/JitStreamer.git#egg=JitStreamer"
fi

# Update Tailscale
echo "Updating Tailscale..."
sudo tailscale update
echo "All updates completed."