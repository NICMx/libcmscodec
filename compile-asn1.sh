#!/bin/sh

die() {
	echo "$1"
	exit 1
}

OUTPUT_DIR=libasn1fort

rm -fr $OUTPUT_DIR || die "Could not delete directory $OUTPUT_DIR."
mkdir -p $OUTPUT_DIR || die "Could not create directory '$OUTPUT_DIR'."

asn1c -Werror -fcompound-names -fwide-types -D $OUTPUT_DIR \
		-no-gen-PER -no-gen-example \
		asn1/*.asn1 || die "Compilation failed."

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

# Replace '#include <file.h>' with '#include <$OUTPUT_DIR/file.h> mostly
# everywhere.
sed -Ei 's!#include <('"$LS"')>!#include <'"$OUTPUT_DIR"'/\1>!' $OUTPUT_DIR/*.c $OUTPUT_DIR/*.h
sed -Ei 's!#include "('"$LS"')"!#include <'"$OUTPUT_DIR"'/\1>!' $OUTPUT_DIR/*.c $OUTPUT_DIR/*.h
# If you're wondering why we bothered with LS instead of something like "(.+\.h)",
# it's because not all #includes need the treatment. For example, some files
# include <errno.h>, which obviously does not belong to $OUTPUT_DIR.

# Change the default name of the library
sed -i 's/libasncodec/libasn1fort/' libasn1fort/Makefile.am.libasncodec
