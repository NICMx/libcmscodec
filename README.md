# libcmscodec

CMS encoders and decoders.

## Installation

Installing a release is a lot easier than the git version.

### Installing a release

Requirements:

- HTTP object retriever (`wget` exampled below)
- tar
- A C compiler

Procedure:

```
wget https://github.com/NICMx/libcmscodec/releases/download/beta1/libcmscodec-beta1.tar.gz
tar xvzf libcmscodec-beta1.tar.gz
cd libcmscodec*
./configure
make
sudo make install
```

### Installing the git version

Requirements:

- git
- The autotools (in particular, autoconf must be 2.69 or newer)
- [asn1c](https://github.com/vlm/asn1c) (Note: A relatively recent version is required. I'm currently using commit [88ed3b5](https://github.com/vlm/asn1c/tree/88ed3b5cf012918bc1084b606b0624c45e0d2191).)
- A C compiler

Procedure:

```
git clone https://github.com/NICMx/libcmscodec.git
cd libcmscodec/
./autogen.sh
./configure
make
sudo make install
```
