=== Nginx ===

Nginx cumple varias funciones en este mirror (también se puede usar Apache)


* Sirve el contenido completo de los mirrors (desde /home/mirrors/*)
* Sirve algunos archivos vía http para el booteo PXE

Se instala en Debian con:

{{{
:~# aptitude install nginx
}}}

La configuración como viene por default (/etc/nginx/sites-available/default) no se toca en lo absoluto, por ese motivo no pongo la config (no es necesaria) aunque hay que tener en consideración algunos puntos importantes


* En Debian el path x default es /usr/share/nginx/www


Por lo que si queremos publicar el contenido de los diferentes mirrors en /home/mirrors con usar un link simbólico a /usr/share/nginx/www es suficiente

{{{
:~# ln -s /home/mirrors/{debian,debian-security,ubuntu,centos,trisquel,linuxmint,} /usr/share/nginx/www
}}}

O hacia /var/www si deciden usar Apache

También deber hacer un link simbólico a /home/tftp para los archivos que se necesiten en el booteo PXE

{{{
:~# ln -s /home/tftp /usr/share/nginx/www
}}}


----
Proxy Reverso

En el caso de NO disponer de un mirror local para la instalación de paquetes de una determinada distribución y se necesiten descargar desde internet, se puede utilizar nginx en modo Proxy Reverso para optimizar el bandwith

Ejemplo en el caso de Fedora distribución de la que NO tenemos mirror en Flisol CABA

.... (falta)



