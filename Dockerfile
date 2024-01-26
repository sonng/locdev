FROM archlinux:latest
LABEL maintainer="Son Nguyen <anh.s.nguyen@gmail.com>"

# Load environment variables
ARG USER
ARG USER_PASSWORD
ARG LOCAL_DEV_SSH_PUB

# Update System
RUN pacman -Syu --noconfirm

# Install packages
RUN pacman -Sy --noconfirm \
fish sudo openssh which

# Add user
RUN useradd -m -G wheel -s /usr/bin/fish ${USER}

# Set password
RUN echo "${USER}:${USER_PASSWORD}" | chpasswd

# Setup wheel
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Disable root ssh login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config

# Disable password login
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Start ssh
RUN systemctl enable sshd.service

USER ${USER}

# Add ssh key
RUN mkdir -p /home/${USER}/.ssh
RUN echo "${LOCAL_DEV_SSH_PUB}" > /home/${USER}/.ssh/authorized_keys

WORKDIR /home/${USER}
