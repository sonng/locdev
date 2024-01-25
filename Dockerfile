FROM archlinux:latest
LABEL maintainer="Son Nguyen <anh.s.nguyen@gmail.com>"

# Load environment variables
ARG USER
ARG USER_PASSWORD

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

USER ${USER}
WORKDIR /home/${USER}
