# Free KVM Installer [MODIFIED Foxytoux Installer]

**EMULATES FULL OF KVM IN QEMU**

that's why it's slow lol

## Overview

This shell script is designed to automate the installation of Foxytoux, a lightweight Ubuntu 20 environment using Proot.
Then we will boot Ubuntu 22 with qemu!
Yeah, you may hear this is as a silly thing, as we boot ubuntu in ubuntu.

## How Does it work?
- Simply installing qemu in Ubuntu 20 PRoot.
- Download Ubuntu 22 file and user-data.
- Boot the Ubuntu 22 with Qemu.
- Enjoy it and install pterodactyl panel with cloudflare and connect minecraft with tailscale
  
## Prerequisites

- Bash shell environment
- Internet connectivity
- Wget installed
- Supported CPU architecture: x86_64 (amd64) or aarch64 (arm64)

## Installation

1. Clone the repository:

    ```sh
    mkdir kvm
    cd kvm
    wget https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/main.sh
    ```

2. Run the installer script:

    ```sh
    bash main.sh
    ```
    or
    ```sh
    chmod +x main.sh
    ./main.sh
    ```

## Login
- user: user
- password: U23rP422w0rd

## Supported Architectures

- x86_64 (amd64)
- aarch64 (arm64)
## Storage
- default: 10G
- adding more(10G) so will be 20G: bash noninteractive.sh then qemu-img resize /root/ubuntu-22.qcow2 +10G
## Something Else Similar
- **[Recommended]**[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/rdpmakers/freeroot-KVM/HEAD)
- **[Recommended]**[Google Colab](https://github.com/rdpmakers/freeroot-KVM/tree/main/ipynb)

## License

This Foxytoux Installer script is released under the [MIT License](LICENSE).

## Credits

me myself editing this script. but the original project was maintained by:

Foxytoux Installer is developed and maintained by RecodeStudios.Cloud.
This installer has been made possible thanks to [dxomg](https://github.com/dxomg) for his proot code

---

**Note:** This script is intended for educational and experimental purposes. Use it responsibly and at your own risk.
