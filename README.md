# libasn1fort

ASN.1 objects for [FORT-validator](https://github.com/NICMx/FORT-validator).

## Installation

```bash
mkdir -p ~/git

cd ~/git
git clone https://github.com/vlm/asn1c.git
cd asn1c
test -f configure || autoreconf -iv
./configure
make
sudo make install

cd ~/git
git clone https://github.com/NICMx/libasn1fort
cd libasn1fort
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
```
