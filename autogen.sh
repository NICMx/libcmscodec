#!/bin/bash

# Hello.
# Run this file to generate the configure script.
# You'll need the autotools installed!

function die {
	echo "$1"
	exit 1
}

cd src
./compile-asn1.sh || die "Could not compile the ASN.1 source. (Do you have asn1c installed?)"
cd ..

autoreconf --install || die "autoreconf failed."
