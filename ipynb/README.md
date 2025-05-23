<p align="center"><img src="https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/ipynb/images.jpeg" alt="Logo" height="80"/></p>
<h1 align="center">Boot Ubuntu 22 In Google Drive</h1>
<p align="center">Run Ubuntu 22 Server on Google Colab and save in Google Drive</p>
<p align="right">
  <a href="https://colab.research.google.com/github/rdpmakers/freeroot-KVM/blob/main/ipynb/BootUbuntu22-GDrive.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"></a>
</p>

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
- Uses [Cloudflare Argo tunnel](https://github.com/cloudflare/cloudflared) for both SSH Server and SSH Client Connect
- Saves all of the data including log files to Google Drive.
