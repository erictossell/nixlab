#!/bin/bash

# Define your server IPs
SERVERS=("192.168.2.195" "192.168.2.196" "192.168.2.197")

# Command to execute
COMMAND="sudo nixos-rebuild switch --flake github:erictossell/nix-pi-lab"
COMMAND_DEV="sudo nixos-rebuild switch --flake github:erictossell/nix-pi-lab/tree/dev"
CLEAN="nix-collect-gargage -d"

# SSH Options
SSH_OPTIONS="-p 2973"

# Loop through the servers and execute the command
for SERVER in "${SERVERS[@]}"; do
    echo "Executing on $SERVER"
    ssh $SSH_OPTIONS eriim@$SERVER "$CLEAN"

    ssh $SSH_OPTIONS eriim@$SERVER "$COMMAND"
done

echo "Execution completed on all servers."

