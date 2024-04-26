## nix-pi-lab

A basic configuration for 3 different raspberry-pi devices running NixOS.
- A live image for flashing SSH access
- Wireless network configuration with Agenix encrypted secrets
- Docker managed by terraform

#### Repository structure:


`nix flake show`

```nix
git+file:///home/runner/work/nixlab/nixlab?shallow=1
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
    disko/
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
        grafana/
        k3s/
        networking/
            wpa/
        nginx/
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
        tandoor/
        x86_64/
            boot/
    secrets/
    sh/
    users/
```

