#- name: set password
#- name: provide ssh key
#
# raspi-config --expand-rootfs
#

- name: erase packages for minimal install
  apt: name={{ item }} state=absent purge=yes
  with_items:
  - desktop-base
  - lightdm
  - lxappearance
  - lxde-common
  - lxde-icon-theme
  - lxinput
  - lxpanel
  - lxpolkit
  - lxrandr
  - lxsession-edit
  - lxshortcut
  - lxtask
  - lxterminal
  - wolfram-engine
  when: minimal

- name: erase Xorg packages
  apt: name={{ item }} state=absent purge=yes
  with_items:
  - obconf
  - openbox
  - raspberrypi-artwork
  - xarchiver
  - xinit
  - xserver-xorg
  - xserver-xorg-video-fbdev
  - x11-utils
  - x11-common
  when: no_xorg

- name: erase no longer required packages
  shell: apt-get -y autoremove
  when: minimal

- name: update fw via rpi-update
  shell: rpi-update

- name: install packages
  apt: name={{ item }} state=present update_cache=yes
  with_items:
  - vim
  - avahi-daemon

- name: dist upgrade
  apt: upgrade=dist

- name: set hostname
  hostname: name={{ hostname }}
