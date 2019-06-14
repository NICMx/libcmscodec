#!/bin/bash

# Hello.
# Run this file to generate Fort's asn1c code.
# You'll need a recent version of asn1c installed!

function die {
	echo "$1"
	exit 1
}

cd src
./compile-asn1.sh || die "Could not compile the ASN.1 source. (Do you have asn1c installed?)"
