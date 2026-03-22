FROM quay.io/fedora/fedora-sway-atomic:43

COPY packages.sh config.sh /
COPY 2022-RH-IT-Root-CA.pem /etc/pki/ca-trust/source/anchors/
RUN /packages.sh
RUN /config.sh
RUN rm /packages.sh /config.sh
