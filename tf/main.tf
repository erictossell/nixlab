provider "null" {
  # Configuration for the null provider
}

resource "null_resource" "nixos_update" {
  count = 3 # Number of devices

  connection {
    type     = "ssh"
    host     = "192.168.2.${195 + count.index}" # Corrected syntax
    user     = "eriim"
    port     = 2973
    timeout  = "2m"
    agent    = true
    ssh_opts = "-o StrictHostKeyChecking=no, -o UserKnownHostsFile=/dev/null"
  }

  provisioner "remote-exec" {
    # Add your script or command here to handle sudo authentication
    # Example: 
    inline = [
      "sudo nixos-rebuild switch --flake 'github:erictossell/nix-pi-lab'"
    ]
  }
}
