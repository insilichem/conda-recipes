#!/bin/bash

if [[ $(uname) = 'Linux' ]]
then
	DIRECTORY="linux${ARCH}"
	DSX_EXECUTABLE="dsx_linux_${ARCH}.lnx"
	HOTSPOT_EXECUTABLE="hotspotsX_linux_${ARCH}.lnx"
else
	DIRECTORY="mac${ARCH}"
	DSX_EXECUTABLE="dsx_mac_${ARCH}.mac"
	HOTSPOT_EXECUTABLE="hotspotsX_mac_${ARCH}.mac"
fi

cp "$DIRECTORY/$DSX_EXECUTABLE" "$DIRECTORY/$HOTSPOT_EXECUTABLE" "$PREFIX/bin/"
ln -s "$PREFIX/bin/$DSX_EXECUTABLE" "$PREFIX/bin/drugscorex"
ln -s "$PREFIX/bin/$HOTSPOT_EXECUTABLE" "$PREFIX/bin/hotspotsx"

mkdir -p "$PREFIX/share/drugscorex"
cp -r "pdb_pot_0511/" "$PREFIX/share/drugscorex/"

mkdir -p "$PREFIX/etc/conda/activate.d/" "$PREFIX/etc/conda/deactivate.d/"

cat > $PREFIX/etc/conda/activate.d/drugscorex_env.sh << "EOF"
export DSX_POTENTIALS="$CONDA_PREFIX/share/drugscorex/pdb_pot_0511"
EOF
cat > $PREFIX/etc/conda/activate.d/drugscorex_env.fish << "EOF"
set -gx DSX_POTENTIALS "$CONDA_PREFIX/share/drugscorex/pdb_pot_0511"
EOF

cat > $PREFIX/etc/conda/deactivate.d/drugscorex_env.sh << "EOF"
unset DSX_POTENTIALS
EOF
cat > $PREFIX/etc/conda/deactivate.d/drugscorex_env.fish << "EOF"
set -e DSX_POTENTIALS
EOF
