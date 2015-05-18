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
