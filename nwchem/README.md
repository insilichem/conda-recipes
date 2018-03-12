NWChem 6.8 conda recipe
=======================

Currently building for Linux 64bit, Python 2.7, openmpi 3.0 and openblas.

Build with following command to avoid path length issues.

```
conda build -c conda-forge --croot /tmp --prefix-length 80 .
```