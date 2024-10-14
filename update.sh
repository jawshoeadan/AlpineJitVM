#!/bin/bash
# Claude helped
# Function to check and update a package
check_and_update_package() {
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
        echo "Unable to determine installed commit hash. Will attempt to update."
        needs_update=true
    elif [ "${latest_commit:0:${#installed_commit}}" != "$installed_commit" ]; then
        echo "New version available."
        needs_update=true
    else
        echo "$package_name is up to date."
        needs_update=false
    fi
    
    if [ "$needs_update" = true ]; then
        echo "Updating $package_name..."
        pip install --upgrade "git+$repo_url#egg=$egg_name"
    fi
}

# Activate the virtual environment
echo "Activating virtual environment..."
source ./venv/bin/activate

# Check and update JitStreamer
check_and_update_package "JitStreamer" "https://github.com/jawshoeadan/JitStreamer.git" "JitStreamer"

# Check and update pymobiledevice3
check_and_update_package "pymobiledevice3" "https://github.com/jawshoeadan/pymobiledevice3.git" "pymobiledevice3"

# Update Tailscale
echo "Updating Tailscale..."
sudo tailscale update

echo "All updates completed."
