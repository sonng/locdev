# Local Dev

The idea is that I have a dev environment that is;

- version controlled
- reproducible
- consistent across multiple machines


VM image is built using [Packer](https://www.packer.io/)
To run these images on the Mac use [Tart](https://tart.run/).

# To Build

## Dependencies

- Brew


## Build Script

Make sure to have the following environment variables

| Envionment Variable | Description |
| -- | -- |
| FEDORA_IMAGE_LOCATION | The absolute path to the image (qcow2) |
| LOCDEV_VM_NAME | Name of VM |
| LOCDEV_USERNAME | User for the VM |
| LOCDEV_PASSWORD | Password for the user |
| LOCDEV_HOSTNAME | Hostname for the VM |

```bash
> ./build.sh
```

# Packages

- OpenSSH: So we can ssh into the instance from our host.
- Neovim: Our primary text editor
- VSCode: Our secondary text editor
- Tmux: Our terminal multiplexer

# Services

- PlantUML: Our diagram tooling
- Docker: So we can do dev

# Virtual machine

- Base Image: Fedora Cloud Image

