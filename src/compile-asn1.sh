#!/bin/bash

function die() {
	echo $1
	exit 1
}

OUTPUT_DIR=libcmscodec

rm -fr $OUTPUT_DIR || die "Could not delete directory $OUTPUT_DIR."
mkdir -p $OUTPUT_DIR || die "Could not create directory '$OUTPUT_DIR'."

# I'm using version 0.9.29. (4cc779f)
#
# http://lionet.info/asn1c
# -gen-autotools isn't doing anything.
# -no-gen-OER yields incorrect code.
asn1c -Werror -fcompound-names -fwide-types -D $OUTPUT_DIR \
		-no-gen-PER -no-gen-example \
		*.asn1 || die "Compilation failed."

echo "Patching include directories from the source. Please wait; this will take a while. (~10 seconds probably.)"
for MODULE in $OUTPUT_DIR/*.h; do
	HNAME=$(basename $MODULE)
	sed -i "s|#include <$HNAME>|#include <libcmscodec/$HNAME>|" $OUTPUT_DIR/*.h $OUTPUT_DIR/*.c
	sed -i "s|#include \"$HNAME\"|#include \"libcmscodec/$HNAME\"|" $OUTPUT_DIR/*.h $OUTPUT_DIR/*.c
done

# Patch Makefile.am.libasncodec
MAKEFILE=$OUTPUT_DIR/Makefile.am.libasncodec
sed -i 's|ASN_MODULE_HDRS|ASN_MODULE_HEADERS|' $MAKEFILE
sed -i 's|ASN_MODULE_SRCS|ASN_MODULE_SOURCES|' $MAKEFILE
sed -i '\|libasncodec_la_CPPFLAGS=-I$(top_srcdir)/libcmscodec/|d' $MAKEFILE
sed -i 's|libasncodec|libcmscodec|' $MAKEFILE
sed -i 's|lib_LTLIBRARIES+=libcmscodec.la|lib_LTLIBRARIES=libcmscodec.la|' $MAKEFILE
printf "\nASN_MODULEdir=@includedir@/libcmscodec\n" >> $MAKEFILE
mv $MAKEFILE Makefile.am
