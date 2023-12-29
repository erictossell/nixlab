param (
    [string]$cmd = "sudo nixos-rebuild switch --flake github:erictossell/nix-pi-lab" # Default command
)

# Define your server IPs
$servers = @("192.168.2.195", "192.168.2.196", "192.168.2.197")

# SSH Options
$sshOptions = "-p 2973"

# Loop through the servers and execute the command
foreach ($server in $servers) {
    Write-Host "Executing on $server"
    ssh $sshOptions eriim@$server $cmd
}

Write-Host "Execution completed on all servers."

