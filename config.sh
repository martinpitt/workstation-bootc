#!/bin/bash
set -xeuo pipefail

# Enable SysRQ
echo 'kernel.sysrq = 1' > /usr/lib/sysctl.d/90-sysrq.conf

# set up PAM for systemd-homed
authselect enable-feature with-systemd-homed

# homed is missing a lot of SELinux policy (https://bugzilla.redhat.com/show_bug.cgi?id=1809878)
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

# enable other units
ln -s ../systemd-timesyncd.service /usr/lib/systemd/system/sysinit.target.wants/systemd-timesyncd.service

# move OS systemd unit defaults to /usr
#cp -a --verbose /etc/systemd/system /etc/systemd/user /usr/lib/systemd/
#rm -r /etc/systemd/system /etc/systemd/user

# update for Red Hat certificate
ln -s /etc/pki/ca-trust/source/anchors/2022-RH-IT-Root-CA.pem /etc/pki/tls/certs/2022-RH-IT-Root-CA.pem
update-ca-trust

# clean up NSS and rpm backup files
rm --verbose /etc/*- /etc/cups/cups-browsed.conf.rpmsave
