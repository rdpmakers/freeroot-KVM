# Boot it by Google Colab
  <a href="https://colab.research.google.com/github/rdpmakers/freeroot-KVM/blob/main/ipynb/BootUbuntu22-GDrive.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"></a>
  
## Benefits
- You can save the project and everything you did to the VM.
- Securely saved to your Google Drive Folder.
- Free to use.
- Simple.

## Disadvantages
- Takes 10GB of your Google Account's Storage.
- Needs to shutdown properly with poweroff command
- idk for the rest.

## How does it work?
- Installs Qemu.
- Bind and mount the google drive.
- Make directory.
- Downloads Ubuntu 22 Server image.
- Boots the Ubuntu 22 Server image.
- Use SSH for both server and client by [Cloudflare Argo tunnel](https://github.com/cloudflare/cloudflared) by websocket with [Wstunnel](https://github.com/erebe/wstunnel).
- Saves the datas to Google Drive.
