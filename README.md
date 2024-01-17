### nix-pi-lab

A basic configuration for 3 different raspberry-pi devices running NixOS.
- A live image for flashing SSH access
- Wireless network configuration with Agenix encrypted secrets
- Docker Swarm Cluster, managed by terraform

`nix flake show`

```nix
github:erictossell/nix-pi-lab/54ae93d918beaceffcbacf1322da18d9b273f3d9
├───devShells
│   ├───aarch64-darwin
│   │   └───default omitted (use '--all-systems' to show)
│   ├───aarch64-linux
│   │   └───default omitted (use '--all-systems' to show)
│   ├───x86_64-darwin
│   │   └───default omitted (use '--all-systems' to show)
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
    └───default: template: A NixOS Flake for raspberry pi devices

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

