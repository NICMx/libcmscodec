#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
# TODO change the bug report address
AC_INIT([libcmscodec], [beta2], [ydahhrk@gmail.com])
AC_CONFIG_SRCDIR([src/libcmscodec/der_encoder.c])
AM_INIT_AUTOMAKE([subdir-objects])

# Checks for programs.
AC_PROG_CC

# Needed by libtool. (Othewise autoreconf complains.)
LT_INIT
# Needed by libtoolize. (Othewise autoreconf complains.)
AC_CONFIG_MACRO_DIRS([m4])

# Spit out the makefiles.
AC_OUTPUT(Makefile src/Makefile)
