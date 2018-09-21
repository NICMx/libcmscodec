#!/bin/bash

function die() {
	echo $1
	exit 1
}

OUTPUT_DIR=libcmscodec

rm -fr $OUTPUT_DIR
mkdir -p $OUTPUT_DIR || die "Could not create directory '$OUTPUT_DIR'."

# I'm using version 0.9.29. (4cc779f)
#
# http://lionet.info/asn1c
# -gen-autotools isn't doing anything.
# -no-gen-OER yields incorrect code.
asn1c -Werror -fcompound-names -D $OUTPUT_DIR \
		-no-gen-PER -no-gen-example \
		*.asn1 || die "Compilation failed."
rm libcmscodec/Makefile.am.libasncodec

for MODULE in $OUTPUT_DIR/*.h; do
	HNAME=$(basename $MODULE)
	sed -i "s|#include <$HNAME>|#include <libcmscodec/$HNAME>|" $OUTPUT_DIR/*.h $OUTPUT_DIR/*.c
	sed -i "s|#include \"$HNAME\"|#include \"libcmscodec/$HNAME\"|" $OUTPUT_DIR/*.h $OUTPUT_DIR/*.c
done
