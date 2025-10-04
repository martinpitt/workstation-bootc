#!/bin/sh
set -eux

# hardware/drivers
dnf install -y \
    kernel-modules-extra \
    iwlwifi-mvm-firmware \
    alsa-sof-firmware \
    blueman \
    NetworkManager-wifi \
    NetworkManager-openvpn-gnome \
    powertop \
    wpa_supplicant

# shell tools and development
dnf install -y \
    cyrus-sasl-plain \
    fpaste \
    git \
    glibc-langpack-de \
    glibc-langpack-en \
    isync \
    krb5-workstation \
    man-db \
    mtr \
    mutt  \
    neovim \
    nmap-ncat \
    restic \
    rsync \
    strace \
    syncthing \
    systemd-container \
    toolbox \
    tree \
    w3m \
    wget

# desktop plumbing/apps
dnf install -y \
    dejavu-sans-fonts \
    dejavu-serif-fonts \
    dejavu-sans-mono-fonts \
    flatpak \
    fontawesome-fonts \
    google-noto-emoji-color-fonts \
    gvfs-mtp \
    pulseaudio-utils \
    alsa-plugins-pulseaudio \
    gstreamer1-plugins-good \
    gstreamer1-plugins-bad-free \
    xdg-desktop-portal-gtk \
    pavucontrol \
    pcmanfm \
    nm-applet \
    nm-connection-editor \
    eog \
    evince \
    rhythmbox \
    gnome-keyring \
    pinentry-gnome3 \
    mate-polkit \
    lxterminal \
    gnome-disk-utility \
    rofimoji

# sway/wayland desktop
dnf install -y \
    sway \
    swayidle \
    swaylock \
    kanshi \
    mako \
    waybar \
    slurp \
    grim \
    xorg-x11-server-Xwayland \
    firefox \
    wofi \
    brightnessctl \
    wl-clipboard

dnf remove -y \
    NetworkManager-cloud-setup \
    adcli \
    avahi \
    btrfs-progs \
    chrony \
    cloud-utils-growpart \
    fwupd \
    libosinfo \
    lvm2 \
    lvm2-libs \
    nfs-utils \
    nilfs-utils \
    passim-libs \
    quota-nls \
    rpcbind \
    sssd-common \
    sssd-nfs-idmap \
    sos \
    tracker \
    tracker-miners \
    udftools \
    vim-data \
    vim-minimal \
    xdg-desktop-portal-wlr \
    zram-generator

# run0!
rm /etc/dnf/protected.d/sudo.conf
dnf remove -y sudo

# not packaged separately; only used by /usr/share/gvfs/mounts/admin.mount which I don't need
rm -f /usr/bin/pkexec

rpm -qa 'qemu-user-static*' | xargs dnf remove -y

dnf clean all
