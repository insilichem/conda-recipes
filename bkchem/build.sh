#!/bin/bash

# Remove the Pmw bundled files
rm -rf $SRC_DIR/bkchem/{Pmw,PmwBlt,PmwColor}.py{,c}
# Remove oasa from package list
# and skip the programmatic creationg of site_config (we will do that manually below)
sed -i '82,$d;/.*oasa.*/d;s/^  version = .*$/  version = '\"${PKG_VERSION}\"',/'  setup.py
# Download submodules manually
curl -s https://gitlab.com/bkchem/piddle/-/archive/91ceda9c3d73829cc4ab922ff3877806beaf3a20/piddle-91ceda9c3d73829cc4ab922ff3877806beaf3a20.tar.gz | tar xvz -C bkchem/plugins/piddle --strip-components=1
curl -s https://gitlab.com/bkchem/bkchem-plugins/-/archive/f2600ac1672f98f93e36d5c382c4a80d47428a19/bkchem-plugins-f2600ac1672f98f93e36d5c382c4a80d47428a19.tar.gz | tar xvz -C plugins --strip-components=1


# Install with pip
${PYTHON} -m pip install . --no-deps -vv

# Create the configuration file for bkchem
cat << EOF > "${SP_DIR}/bkchem/site_config.py"
# the bkchem configuration file, do not edit!
# (unless you are pretty sure that you know what you are doing, which even I am not)
BKCHEM_MODULE_PATH="${SP_DIR}/bkchem"
BKCHEM_TEMPLATE_PATH="${PREFIX}/share/bkchem/templates"
BKCHEM_PIXMAP_PATH="${PREFIX}/share/bkchem/pixmaps"
BKCHEM_IMAGE_PATH="${PREFIX}/share/bkchem/images"
BKCHEM_PLUGIN_PATH="${PREFIX}/share/bkchem/plugins"
EOF

# Create the bkchem executable manually
ln -s "${SP_DIR}/bkchem/bkchem.py" "${SP_DIR}/bkchem/__main__.py"
cat << "EOF" > "${PREFIX}/bin/bkchem"
#!/bin/sh
python -m bkchem $@
EOF