packer {
  required_plugins {
    tart = {
      version = ">= 1.6.1"
      source  = "github.com/cirruslabs/tart"
    }
    ansible = {
      source = "github.com/hashicorp/ansible"
      version = ">= 1.1.1"
    }
  }
}

variable "ssh_username" {
    default = env("LOCDEV_USERNAME")

    validation {
        condition = length(var.ssh_username) > 0
        error_message = "Please set LOCDEV_USERNAME environment variable to the username for ssh."
    }
}

variable "ssh_password" {
    default = env("LOCDEV_PASSWORD")

    validation {
        condition = length(var.ssh_password) > 0
        error_message = "Please set LOCDEV_PASSWORD environment variable to the password for ssh."
    }
}

variable "vm_name" {
    default = env("LOCDEV_VM_NAME")
}

source "tart-cli" "tart" {
    vm_name = "${var.vm_name}"
    disk_size_gb = 100
    run_extra_args = ["--disk", "cloud-init.iso"]
    headless = false
    ssh_username = "${var.ssh_username}"
    ssh_password = "${var.ssh_password}"
}

build {
    sources = ["source.tart-cli.tart"]

    provisioner "ansible" {
        playbook_file = "./playbook.yml"
    }

    provisioner "shell" {
        inline = [
            "echo 'datasource_list: [ None ]' | sudo -s tee /etc/cloud/cloud.cfg.d/99_no_datasource.cfg",
        ]
    }

}

