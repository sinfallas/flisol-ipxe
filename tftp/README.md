=== TFTP  ===

Esta es la configuración TFTP que se utilizará en el evento, se contempla que todo el contenido de este directorio esté en /home/tftp por lo que si utilizan otro path deben editar los *.cfg correspondientes (también en {{{/etc/dnsmasq.conf}}} y en {{{/etc/exports}}})

==== Contenido ====

-rw-r--r--  1 cmiranda cmiranda  26K Mar 21 14:29 memdisk
-rw-r--r--  1 cmiranda cmiranda  26K Mar 15 13:30 pxelinux.0
drwxr-xr-x  2 cmiranda cmiranda 4.0K Mar 26 00:28 pxelinux.cfg
-rw-r--r--  1 cmiranda cmiranda 1.1K Apr  6 15:12 README.creole
-rw-r--r--  1 cmiranda cmiranda 280K Mar 28 01:28 splash.png
-rw-r--r--  1 cmiranda cmiranda 153K Mar 28 01:25 vesamenu.c32


* {{{pxelinux.0}}} es el archivo inicial con el que se bootea por PXE
* {{{memdisk}}} es utilizado por algunos LiveCDs si necesitamos bootear directamente un *.iso (sólo es eficiente en isos pequeños, ya que se copia íntegramente al cliente antes de bootear)
* {{{vesamenu.c32}}} es un binario que nos permite darle un diseño mas agradable al menu PXE
* {{{splash.png}}} background para vesamenu.c32
* {{{pxelinux.cfg}}} es el directorio que contiene la configuración del menu PXE (MUY IMPORTANTE)
* {{{boot}}} es el directorio donde se copiará el contenido de los CDs y LiveCDs de instalación que serán necesarios para bootear por PXE, en el server http://mstaaravin.no-ip.org/tftp/boot (es mi server personal en casa y no está siempre online) tienen una estructura de directorios y archivos de configuración ya armada y funcional a modo de ejemplo.

A continuación un ejemplo de cómo armar la estructura de booteo para Debian & LinuxMint

===== Debian (text installer) =====
Debian es realmente simple en su estructura de instalación, para este caso crearemos la estructura de directorios

{{{

cmiranda@lhome:~$ mkdir -p /home/tftp/boot/debian/{wheezy/{amd64,i386},jessie/{amd64,i386}}
cmiranda@lhome:~$ tree -d -L 2 /home/tftp/boot/debian/
/home/tftp/boot/debian/
├── jessie
│   ├── amd64
│   └── i386
└── wheezy
    ├── amd64
    └── i386
}}}

Descargamos el kernel y el initrd

{{{
cmiranda@lhome:~$ wget -P /home/tftp/boot/debian/wheezy/amd64/ http://mirrors.kernel.org/debian/dists/wheezy/main/installer-amd64/current/images/netboot/debian-installer/amd64/linux
cmiranda@lhome:~$ wget -P /home/tftp/boot/debian/wheezy/amd64/ http://mirrors.kernel.org/debian/dists/wheezy/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz
}}}

Deben hacer lo mismo para el resto de las arquitecturas (i386, etc) y versiones (jessie, etc)\\
Para el LiveCD de Debian deben usar como ejemplo el procedimiento de LinuxMint (a continuación)

===== LinuxMint (LiveCD) =====
LinuxMint por ejemplo consta de la siguiente estructura de directorios

{{{
cmiranda@lhome:~$ tree -d -L 1 /home/tftp/boot/linuxmint/
/home/tftp/boot/linuxmint/
├── cinnamon32
├── cinnamon64
├── mate32
├── mate64
├── xfce32
└── xfce64

}}}

La cual fue previamente creada:

{{{

cmiranda@lhome:~$ mkdir -p /home/boot/linuxmint/{cinnamon32,cinnamon64,mate32,mate64,xfce32,xfce64}
}}}

Se entiende que cinnamon64 corresponde al CD con Cinnamon de 64bits (LinuxMint tiene un CD/DVD específico para cada desktop); Bajamos los *.iso correspondientes\\
Descargaremos el iso, hacemos mount y copiamos el contenido completo al directorio destino y hacemos lo mismo para cada versión de LinuxMint que necesitemos bootear por PXE

{{{
cmiranda@lhome:~$ wget http://mirrors.kernel.org/linuxmint/stable/16/linuxmint-16-cinnamon-dvd-64bit.iso
cmiranda@lhome:~$ sudo mount linuxmint-16-cinnamon-dvd-64bit.iso /mnt
cmiranda@lhome:~$ rsync -avr /mnt/ /home/tftp/boot/linuxmint/cinnamon64/
}}}


===== Fedora (Install DVD) =====
Se deben crear los siguientes directorios
{{{
mkdir -p /home/tftp/boot/fedora/20/{x86_64,i386}
}}}

Se debe bajar los siguientes archivos:
{{{
wget -P /home/tftp/boot/fedora/20/x86_64/ http://fedora.mirror.nexicom.net/linux/releases/20/Fedora/x86_64/os/isolinux/vmlinuz
wget -P /home/tftp/boot/fedora/20/x86_64/ http://fedora.mirror.nexicom.net/linux/releases/20/Fedora/x86_64/os/isolinux/initrd.img
wget -P /home/tftp/boot/fedora/20/i386/ http://fedora.mirror.nexicom.net/linux/releases/20/Fedora/i386/os/isolinux/vmlinuz
wget -P /home/tftp/boot/fedora/20/i386/ http://fedora.mirror.nexicom.net/linux/releases/20/Fedora/i386/os/isolinux/initrd.img
}}}

Deben respetar todos los paths ya que estos se utilizan desde el archivo {{{/home/tftp/pxelinux.cfg/installers.conf}}}


