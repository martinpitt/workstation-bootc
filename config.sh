#!/bin/bash
set -xeuo pipefail

# Enable SysRQ
echo 'kernel.sysrq = 1' > /usr/lib/sysctl.d/90-sysrq.conf

# power saving
echo 'blacklist e1000e' > /usr/lib/modprobe.d/blacklist-local.conf

# set up PAM for systemd-homed
authselect enable-feature with-systemd-homed

# homed is missing a lot of SELinux policy (https://bugzilla.redhat.com/show_bug.cgi?id=1809878)
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

# enable other units
ln -s ../systemd-timesyncd.service /usr/lib/systemd/system/sysinit.target.wants/systemd-timesyncd.service

# disable unwanted services
ln -sfn /dev/null /usr/lib/systemd/user/at-spi-dbus-bus.service

# move OS systemd unit defaults to /usr
cp -a --verbose /etc/systemd/system /etc/systemd/user /usr/lib/systemd/
rm -r /etc/systemd/system /etc/systemd/user

# scanner permissions without scanner packages
echo 'ACTION=="add|change", ENV{DEVTYPE}=="usb_device", ENV{ID_MODEL}=="CanoScan", MODE="666"' > /usr/lib/udev/rules.d/canoscan.rules

# battery health
echo 'ACTION=="add|change", ATTR{type}=="Battery", ATTR{charge_stop_threshold}="80"' > /usr/lib/udev/rules.d/80-battery-health.rules

# update for Red Hat certificate
ln -s /etc/pki/ca-trust/source/anchors/2022-RH-IT-Root-CA.pem /etc/pki/tls/certs/2022-RH-IT-Root-CA.pem
update-ca-trust

# clean up NSS backup files
rm --verbose /etc/*-
