#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([libasn1fort],[0.1.0],[validadorfort@fortproject.net])
AC_CONFIG_SRCDIR([libasn1fort/INTEGER.c])
AM_INIT_AUTOMAKE([subdir-objects])

AC_CONFIG_MACRO_DIRS([m4])
LT_INIT

AC_PROG_CC
AC_CONFIG_HEADERS([libasn1fort/config.h])
AC_CHECK_HEADERS([stdlib.h string.h unistd.h])
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_CHECK_HEADER_STDBOOL
AC_FUNC_MALLOC
AC_CHECK_FUNCS([memset])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
