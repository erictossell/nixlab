## nix-pi-lab

A basic configuration for 3 different raspberry-pi devices running NixOS.
- A live image for flashing SSH access
- Wireless network configuration with Agenix encrypted secrets
- Docker Swarm Cluster, managed by terraform

#### Repository structure:


`nix flake show`

```nix
github:erictossell/nix-pi-lab/b21f79340dbec764db62c8e72ee0e6dfde49fb91
├───devShells
│   ├───aarch64-linux
│   │   └───default: development environment 'nix-shell'
│   └───x86_64-linux
│       └───default: development environment 'nix-shell'
├───formatter
│   └───x86_64-linux: package 'nixpkgs-fmt-1.3.0'
├───nixosConfigurations
│   ├───live-image: NixOS configuration
│   ├───nixboard: NixOS configuration
│   ├───nixbox: NixOS configuration
│   ├───nixcube: NixOS configuration
│   └───terminus: NixOS configuration
└───templates
    └───default: template: A NixOS Flake for raspberry pi devices running docker or podman.

```

`Directory Tree`

```bash
./
    docs/
    hosts/
        live-image/
        nixboard/
        nixbox/
        nixcube/
        terminus/
    modules/
        agenix/
        aws/
        boot/
        core/
        docker/
        k3s/
        network/
        networking/
            wpa/
        nix/
        pkgs/
        podman/
        postgres/
        rpi/
            3/
            4/
            boot/
            core/
        rpi4_core/
        samba-server/
        ssh/
        x86_64/
            boot/
    secrets/
    sh/
    users/
```

