## How it all works

There are three different raspberry-pi devices managed in this repository and a custom installation configuration that enables SSH with my key's out of the box.

| Hostname | Specifications |
| --- | --- |
| `nixbox` | 8GB Raspberry Pi 4 |
| `nixboard` | 4GB Raspberry Pi 400 |
| `nixcube` | 1GB Raspberry Pi 3b |
| `live-image` | Installation media with SSH configured |

After a device is installed and connected to the internet either via ethernet or by configuring a wireless connection each device assumes it's role in the cluster.

All deployments of this repository are managed from an external deployment machine in a single action (ie my desktop, or a github action runner) with the custom deploy scripts under `sh/`.

The configurations in this repository are easy to re-use in a range of environments and scenarios that enable SSH access. 

The target for my own configuration here are small `arm` devices but `x86_64` devices are also supported in this `flake` with a few extra modules.

### Commands

All commands are from the perspective of the `cwd` of the `flake.nix`.

| Command | Action |
| --- | --- |
| `python sh/dep.py --command "ls"` | Run any command over SSH accross all devices |

