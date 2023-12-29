#!/bin/bash

# Define your server IPs
SERVERS=("192.168.2.195" "192.168.2.196" "192.168.2.197")

# Default commands
DEFAULT_COMMAND="sudo nixos-rebuild switch --flake github:erictossell/nix-pi-lab"

# SSH Options
SSH_OPTIONS="-p 2973"

# Check for passed command; use default if not provided
COMMAND=${1:-$DEFAULT_COMMAND}

# Loop through the servers and execute the command
for SERVER in "${SERVERS[@]}"; do
    echo "Executing on $SERVER"
    ssh $SSH_OPTIONS eriim@$SERVER "$COMMAND"
done

echo "Execution completed on all servers."

