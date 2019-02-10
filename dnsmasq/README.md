=== DNSMASQ ===

dnsmasq es un excelente software, muy simple y que nos permite disponer de 3 servicios claves en un evento como Flisol (DNS, DHCP, TFTP)

Se instala en Debian con:

{{{
:~# aptitude install dnsmasq
}}}

* DHCP obviamente se encargará de asignar las IPs en nuestra LAN
* DNS por que simularemos que determinados dominios (ftp.debian.org, ftp.ccc.uba.ar, ar.archive.ubuntu.com, etc) que son los que usan como repositorios las distribuciones que instalaremos  se resolverán a la IP privada del server (192.168.122.1) donde nginx servirá los paquetes que previamente habremos bajado con debmirror.
* TFTP para permitir el boot inicial mediante PXE y que también depende de la configuración NFS


El archivo /etc/dnsmasq.conf es autoexplicativo y así como está AMMA (a mi me anda)


==== /etc/banner_add_hosts ====
Una de las funcionalidades de DNSMASQ es funcionar como split-horizon por lo que podemos simular que determinado host en internet se corresponde con la IP privada del server.
Para eso se utiliza la linea {{{addn-hosts=/etc/banner_add_hosts}}} donde especificaremos qué dominios van a apuntar a la IP 192.168.122.1 que es donde escuchará nginx

Es importante que durante la instalación de las distribuciones se seleccione Argentina como pais, en el caso de ubuntu automáticamente agrega {{{ar.archive.ubuntu.com}}} al {{{/etc/apt/sources.list}}}

{{{
192.168.122.1 ar.archive.ubuntu.com
192.168.122.1 ftp.debian.org
192.168.122.1 ftp.ccc.uba.ar
}}}


==== /etc/dnsmasq.conf ====
{{{
domain-needed
bogus-priv
filterwin2k
resolv-file=/etc/resolv.conf
strict-order
# no-resolv
no-poll
server=8.8.8.8
server=208.67.222.222
server=8.8.4.4
server=208.67.220.220


listen-address=192.168.122.1

bind-interfaces

addn-hosts=/etc/banner_add_hosts

domain=flisol2014

dhcp-range=192.168.122.10,192.168.122.254,255.255.255.0,96h

dhcp-option=option:router,192.168.122.1
dhcp-option=option:dns-server,192.168.122.1

enable-tftp
tftp-root=/home/tftp
dhcp-boot=pxelinux.0

dhcp-leasefile=/var/lib/misc/dnsmasq.leases

dhcp-authoritative

log-facility=/var/log/dnsmasq.log
log-dhcp

cache-size=8192
log-async=5
no-negcache

}}}


