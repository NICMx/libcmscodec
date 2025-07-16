#!/bin/sh

# Hello.
# Run this file to generate Fort's asn1c code.

die() {
	echo "$1"
	exit 1
}

./compile-asn1.sh || die "Could not compile the ASN.1 source. (Do you have asn1c installed?)"

mkdir -p m4
autoreconf --force --install # --verbose
