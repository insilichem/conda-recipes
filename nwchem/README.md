NWChem 6.8.1 conda recipe
=========================

Currently building for Linux 64bit, Python 2.7, openmpi 3.1 and openblas.

Build with following command to avoid path length issues.

```
conda build -c conda-forge --croot /tmp --prefix-length 80 .
```

## Currently broken!

This recipe is not workin as of Jan 2019. It used to work in ~Mar2018, but not now. I guess it has to do with the new `conda-build`. I have tried to adapt the recipe (include `host` and `build` sections) to no avail.

These are the two errors I have identified (not sure if the first was already present in the previous working build for `v6.8`).

### Some problems with GA

- `nwchem-6.8.1/src/tools/build/config.h: No such file or directory`. I guess that as a result:
- `nwchem-6.8.1/src/tools/install/bin/ga-config` cannot be found during the first stages (`make 64_to_32`).


### Problems with gfortran

`conda` new compilers seem to mess with something. This happens after ~40 mins:

```
[...]
jgesvd.F:13: note: === vect_analyze_slp ===
jgesvd.F:13: note: Failed to SLP the basic block.
jgesvd.F:13: note: not vectorized: failed to find SLP opportunities in basic block.
gfortran: error: x86_64-conda_cos6-linux-gnu-gfortran: No such file or directory
make: *** [GNUmakefile:35: all] Error 1
gfortran  -c -m64 -ffast-math  -Warray-bounds -fdefault-integer-8 -finline-functions -O2  -Wuninitialized -fno-aggressive-loop-optimizations -O3  -mfpmath=sse  -ffast-math  -fprefetch-loop-arrays  -ftree-vectorize   -fopt-info-vec -mtune=native -I.  -I$SRC_DIR/nwchem-6.8.1/src/include -I$SRC_DIR/nwchem-6.8.1/src/tools/install/include -DMPICH_NO_ATTR_TYPE_TAGS -DGFORTRAN -DCHKUNDFLW -DGCC4 -DGCC46 -DEXT_INT -DLINUX -DLINUX64 -DSCALAPACK -DPARALLEL_DIAG   ifily.F
[...]
```