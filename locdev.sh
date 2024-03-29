#!/bin/bash
set -x

function install_dependencies() {
    # Install Tart
    brew install cirruslabs/cli/tart

    # Install build dependencies
    brew install qemu cdrtools packer
}

function prepare_disk() {
    # Copy Image Disk
    cp $VM_IMAGE_LOCATION /tmp/vm_image.qcow2

    # Convert & Resize Image Disk
    qemu-img convert -p -f qcow2 -O raw /tmp/vm_image.qcow2 /tmp/vm_image.raw
}

function prepare_cloud_init() {
    # Create Cloud Image
    echo "local-hostname: $LOCDEV_HOSTNAME" > cloud-init/meta-data

    # replace $USER in user-data with the current user
    sed "s%\$USER%$LOCDEV_USERNAME%g; s%\$PASSWORD%$LOCDEV_PASSWORD%g; s%\$SSH_KEY%$LOCDEV_SSH_KEY%g" templates/user-data.template > cloud-init/user-data

    mkisofs -output cloud-init.iso -volid cidata -joliet -rock cloud-init/

    cp cloud-init.iso /tmp/cloud-init.iso
}

function create_vm() {
    # Create VM
    tart delete "$LOCDEV_VM_NAME" || true
    tart create --linux "$LOCDEV_VM_NAME"
    mv /tmp/vm_image.raw ~/.tart/vms/$LOCDEV_VM_NAME/disk.img
}

function pack_image() {
    packer init images/
    packer build images/
}

function release() {
    # Clean and build
    clean
    build

    # Push
    tart push "$LOCDEV_VM_NAME" ghcr.io/"$GITHUB_ORG"/"$LOCDEV_VM_NAME":latest ghcr.io/"$GITHUB_ORG"/"$LOCDEV_VM_NAME":"$(date +%s)"

    # Clean up everything
    clean
}
function build() {
    install_dependencies
    prepare_disk
    prepare_cloud_init
    create_vm
    pack_image
}

function clean() {
    rm -rf /tmp/vm_image.raw
    rm -rf /tmp/cloud-init.iso
    rm -rf cloud-init.iso
    rm -rf cloud-init/user-data
    rm -rf cloud-init/meta-data
    
    tart delete "$LOCDEV_VM_NAME" || true
}

function print_usage() {
    echo "Usage: locdev-cli <command>"
    echo "Available commands: build, clean, docker_login"
    exit 1
}

if [[ $# -eq 0 ]]; then
    print_usage
fi

case "$1" in
    build)
        build
        ;;
    clean)
        clean
        ;;
    cleanbuild)
        clean
        build
        ;;
    docker_login)
        docker_login
        ;;
    release)
        release
        ;;
    *)
        print_usage
        ;;
esac
