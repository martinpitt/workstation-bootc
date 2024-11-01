FROM quay.io/centos-bootc/centos-bootc:stream9
RUN dnf -y install cockpit-ws cockpit-bridge
RUN systemctl enable cockpit.socket
