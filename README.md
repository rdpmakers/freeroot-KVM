# Foxytoux Installer [MODIFIED]

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
    git clone https://github.com/rdpmakers/freeroot-KVM
    cd freeroot-KVM
    ```

2. Run the installer script:

    ```sh
    ./root.sh
    ```
    or
    ```sh
    bash root.sh
    ```

## Login
- user: ubuntu
- password: asdfqwer

## Supported Architectures

- x86_64 (amd64)
- aarch64 (arm64)

## License

This Foxytoux Installer script is released under the [MIT License](LICENSE).

## Credits

me myself editing this script. but the original project was maintained by:

Foxytoux Installer is developed and maintained by RecodeStudios.Cloud.
This installer has been made possible thanks to [dxomg](https://github.com/dxomg) for his proot code

---

**Note:** This script is intended for educational and experimental purposes. Use it responsibly and at your own risk.
