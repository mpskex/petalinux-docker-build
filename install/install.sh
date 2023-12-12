#!/usr/bin/bash
sudo service tftpd-hpa start;
sudo -i -u petalinux bash << EOF
echo "Switching user"
/workspace/docker-build/install/${PETALINUX_INSTALLER} --log /workspace/petalinux_installer.log  -d /workspace/petalinux --skip_license;
EOF
echo "Out"