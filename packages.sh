#!/bin/sh
set -eux

# hardware/drivers
dnf install -y \
    powertop \
    tpm2-pkcs11-tools \
    tpm2-pkcs11 \
    tpm2-tools \


# shell tools and development
dnf install -y \
    cyrus-sasl-plain \
    fpaste \
    isync \
    krb5-workstation \
    mutt  \
    neovim \
    openssl \
    restic \
    rsync \
    strace \
    syncthing \
    w3m \


# desktop apps
dnf install -y \
    evince \
    mate-polkit \
    rhythmbox \
    rofimoji \
    vte291 \


# sway/wayland desktop
dnf install -y \
    wofi \
    brightnessctl \
    wl-clipboard

dnf remove -y \
    antiword \
    avahi \
    b43-fwcutter \
    b43-openfwwf \
    chrony \
    cups \
    firewalld \
    fwupd \
    ghostscript \
    gutenprint-libs \
    hyperv-daemons \
    ibus \
    ipp-usb \
    lvm2 \
    lvm2-libs \
    ModemManager \
    nfs-utils \
    nilfs-utils \
    nodejs \
    passim-libs \
    ppp \
    quota-nls \
    rpcbind \
    sssd-common \
    sssd-nfs-idmap \
    sos \
    system-config-printer \
    udftools \
    usb_modeswitch \
    vim-data \
    vim-minimal \
    virtualbox-guest-additions \
    zram-generator

# flatpaks
flatpak uninstall --all -y

# run0!
rm /etc/dnf/protected.d/sudo.conf /usr/share/dnf5/libdnf.conf.d/protect-sudo.conf
dnf remove -y sudo
# dnf does not fail if sudo removal fails, so double-check
if rpm -q sudo; then
    echo "sudo removal failed"
    exit 1
fi

# not packaged separately; only used by /usr/share/gvfs/mounts/admin.mount which I don't need
rm -f /usr/bin/pkexec

rpm -qa 'qemu-user-static*' | xargs dnf remove -y

dnf clean all
