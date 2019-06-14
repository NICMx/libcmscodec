# libcmscodec

This is a code generator. It spawns the original version of [Fort](https://github.com/NICMx/FORT-validator)'s [asn1/asn1c directory](https://github.com/NICMx/FORT-validator/tree/master/src/asn1/asn1c) from scratch.

This is only relevant sometimes during Fort's development. If you're a user, or even a casual developer, you don't care.

## Procedure

First, install `asn1c`. You need a relatively recent commit; the last release is not enough.

```
git clone https://github.com/vlm/asn1c.git
# This is the one I'm currently using as of 2019-06-14, but the newest available is probably best.
git checkout 88ed3b5cf012918bc1084b606b0624c45e0d2191
cd asn1c
# Dummy installation steps follow. You might be better off reading their INSTALL.md instead.
./configure
make
sudo make install
```

Then, go to libcmscodec's repository and run `autogen.sh`.

```
git clone https://github.com/NICMx/libcmscodec
cd libcmscodec
./autogen.sh
```

Then manually copy the resulting `src/asn1/asn1c` directory to Fort.
