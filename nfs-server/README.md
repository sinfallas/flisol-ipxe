=== NFS Server ===

El server utilizará NFS para publicar los distintos directorios que se necesitan para bootear algunos de los LiveCDs tales como LinuxMint, Gentoo, etc

==== Instalación ====
{{{
	:~# aptitude install nfs-kernel-server
}}}


==== /etc/exports  ====
Tan sólo es necesaria una linea en el archivo /etc/exports
{{{
/home/tftp *(ro,insecure,no_subtree_check)
}}}

Ante cualquier cambio en este archivo, no olvidar de hacer un reload del server nfs

{{{
	:~# exportfs -a
}}}

