# Define your server IPs
$servers = @("192.168.2.195", "192.168.2.196", "192.168.2.197")

# Command to execute
$clean = "nix-collect-garbage -d"
$command = "sudo nixos-rebuild switch --flake github:erictossell/nix-pi-lab"

# SSH Options
$sshOptions = "-p 2973"

# Loop through the servers and execute the command
foreach ($server in $servers) {
    Write-Host "Executing on $server"
    ssh $sshOptions eriim@$server $clean
    ssh $sshOptions eriim@$server $command
}

Write-Host "Execution completed on all servers."

