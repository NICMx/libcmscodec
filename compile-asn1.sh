#!/bin/bash

function die() {
	echo $1
	exit 1
}

OUTPUT_DIR=asn1/asn1c

rm -fr $OUTPUT_DIR || die "Could not delete directory $OUTPUT_DIR."
mkdir -p $OUTPUT_DIR || die "Could not create directory '$OUTPUT_DIR'."

# I'm using version 0.9.29. (4cc779f)
#
# http://lionet.info/asn1c
# -gen-autotools isn't doing anything.
# -no-gen-OER yields incorrect code.
# -fincludes-quoted is garbage, because it only affects a few files. (ie. those
# that aren't straight copied from a template.)
asn1c -Werror -fcompound-names -fwide-types -D $OUTPUT_DIR \
		-no-gen-PER -no-gen-example \
		*.asn1 || die "Compilation failed."

# That's most of the work done. From now on, we will do some patching on the
# files asn1c spew.

# ------------------------------------------------------------------------------

# First: asn1c output includes like this: #include <file.h>
# It needs to be like this:               #include "$OUTPUT_DIR/file.h"
# Why? We don't want the <> syntax because we're not including system headers.
# And we want all includes to be relative to the root of fort's source (src/).
# (This prevents some forms of file name collisions.)

# Build a regular expression consisting of the $OUTPUT_DIR files, joined by
# pipes:
# 1. ls: Get a list of file names in $OUTPUT_DIR, one per line
#          AlgorithmIdentifier.c
#          AlgorithmIdentifier.h
#          ANY.c
#          ANY.h
#          etc
# 2. paste: join the file names using a pipe character. ("or" character in
#    regexps.)
#          AlgorithmIdentifier.c|AlgorithmIdentifier.h|ANY.c|ANY.h|etc
# 3. sed: Escape the periods. (so they won't mean "anything".)
#          AlgorithmIdentifier\.c|AlgorithmIdentifier\.h|ANY\.c|ANY\.h|etc
LS=$(ls -1 $OUTPUT_DIR | paste -sd "|" - | sed -E "s/\./\\\./g")
# Replace '#include <file.h>' with '#include "$OUTPUT_DIR/file.h" mostly
# everywhere.
sed -Ei 's!#include <('"$LS"')>!#include "'"$OUTPUT_DIR"'/\1"!' $OUTPUT_DIR/*.c $OUTPUT_DIR/*.h
# If you're wondering why we bothered with LS instead of something like (.+\.h),
# it's because not all #includes need the treatment. For example, some files
# include <errno.h>, which obviously does not belong to $OUTPUT_DIR.


# Second: Fix $OUTPUT_DIR/Makefile.am.libasncodec
# We want to remove some sample code intended to build some library, which we
# don't need, and which adds some warnings to the autogen.
# We do this by removing the last 6 lines of Makefile.am.libasncodec.
# It's not fireproof, but I can't think of a simple more scalable way to do it.
# Also rename the file to something that won't be mistaken for an actual
# Makefile.
head -n -6 $OUTPUT_DIR/Makefile.am.libasncodec > $OUTPUT_DIR/Makefile.include
rm $OUTPUT_DIR/Makefile.am.libasncodec
