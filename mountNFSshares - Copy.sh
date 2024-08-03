#!/bin/bash
set -x

# Array of NFS shares and their corresponding mount points
declare -A nfs_shares
nfs_shares=(
    ["server:/export/share1"]="/mnt/share1"
    ["server:/export/share2"]="/mnt/share2"
    ["server:/export/share3"]="/mnt/share3"
)

# Sleep duration in seconds
sleep_duration=10

# Iterate through the NFS shares array and mount each one
for share in "${!nfs_shares[@]}"; do
    mount_point="${nfs_shares[$share]}"
    
    # Create mount point directory if it does not exist
    if [ ! -d "$mount_point" ]; then
        echo "Creating directory: $mount_point"
        mkdir -p "$mount_point"
    fi

    # Mount the NFS share
    echo "Mounting NFS share: $share at $mount_point"
    mount -t nfs "$share" "$mount_point"

    # Sleep before mounting the next share
    echo "Sleeping for $sleep_duration seconds"
    sleep "$sleep_duration"
done

echo "All NFS shares have been mounted."
