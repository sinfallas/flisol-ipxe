#!/bin/sh

# Architecture (i386, powerpc, amd64, etc.)
arch=i386,amd64

# Section (main,contrib,non-free)
section=main,main/debian-installer,contrib,contrib/debian-installer,non-free,non-free/debian-installer

# Release of the system (wheezy,jessie,stable,testing,etc)
release=jessie,jessie-backports,jessie-updates,jessie-proposed-updates

# Server name, minus the protocol and the path at the end
server=mirrors.kernel.org

# Path from the main server, so http://my.web.server/$dir, Server dependant
inPath=/debian

# Protocol to use for transfer (http, ftp, hftp, rsync)
proto=http

# Directory to store the mirror in
outPath=/flisol/mirrors/debian

# Start script
debmirror	-a $arch \
		--no-source \
		--md5sums \
		--verbose \
		--getcontents \
		--diff=mirror \
		--ignore-small-errors \
		-i18n \
		--no-check-gpg \
		--ignore-release-gpg \
                --di-dist=jessie \
                --di-arch=i386,amd64 \
		--exclude='/Translation-.*\.bz2$' \
		--include='/Translation-en.*\.bz2$' \
		--include='/Translation-es.*\.bz2$' \
		-s $section \
		-h $server \
		-d $release \
		-r $inPath \
		-e $proto \
		$outPath
