RaspberryPi kickstart
=====================

Ansible scripts for kickstarting
and managing your Raspberries.

Requirements
------------

- Raspberry Pi
- up to date Debain image with systemd
- ansible >= 1.9

Getting your RPi online
-----------------------

Your RPi has to be available on your local network
with internet connection. This is easily achieved with
B models where you only need to connect ethernet cable
and find the device.

Where's my RPi
~~~~~~~~~~~~~~

- if you're using OpenWRT you might be able to
  reach your RPi under `rasbperrypi.lan` hostname::

        ping rasbperrypi.lan

- you can also look-up your RPi's IP address on your
  router's DHCP lease list
- or find it with nmap (provided you're on a `10.0.0.0/24` network::

        nmap -p 22 -T aggressive 10.0.0.*


Wifi client connection
~~~~~~~~~~~~~~~~~~~~~~

- if you need to connect to wifi network, remove SD card
  from your RPi and plug it in your computer. Then mount
  the second partition containing system files - as root run::

        mount /dev/mmcblk0p2 /mnt; pushd mnt

- alter ``etc/network/interfaces``
  according to ``files/interfaces.sample``
- then edit ``etc/wpa_supplicant/wpa_supplicant.conf``
  according to ``files/wpa_supplicant.conf.sample``
- when done, change directory back and unmount::

        popd; umount /mnt

- plug the SD card back and start your RPi

Usage
-----

- ``git clone https://github.com/sorki/rpi_kickstart``
- ``cd rpi_kickstart``
- if your RPi is accessible under ``raspberrypi.lan``
  hostname you can now run::

        ./kickstart

- if not you have to alter ``kickstart_hosts`` file
  to match your RPi's hostname and re-run the command

- after kickstart finishes add your RPi's hostname to
  ``hosts`` and ``site.yml`` files and provision using::

        ./run

- you can now configure your RPi by creating a
  ``host_vars/<HOSTNAME>`` file, for example if your
  RPi is using `myrpi.lan` hostname and you want to
  disable tty on UART::

        echo 'uart_tty_enable: false' > host_vars/myrpi.lan
