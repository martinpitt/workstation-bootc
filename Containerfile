FROM quay.io/fedora/fedora-bootc:43

COPY packages.sh /
COPY 2022-RH-IT-Root-CA.pem /etc/pki/ca-trust/source/anchors/
COPY rpmfusion.repo /etc/yum.repos.d/
RUN /packages.sh; rm /packages.sh

COPY config.sh /
RUN /config.sh; rm /config.sh
