#!/bin/sh
fdisk /dev/mmcblk0 <<EOF
p
d
2
n
p
2


p
w
EOF

resize2fs /dev/mmclbk0p2
