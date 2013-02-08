#!/bin/sh

vagrant_switch="--vagrant"

if [ $# -gt 1 ]; then
  echo "Usage: $0 [ $vagrant_switch ]" >&2
  exit 1
fi

if [ $# -eq 1 ] && [ "$1" != "$vagrant_switch" ]; then
  echo "Usage: $0 [ $vagrant_switch ]" >&2
  exit 1
fi

branch=master
name=selenium-grid
repo=Publero/$name

# Download installation content & prepare
wget -O $name.tar.gz https://github.com/$repo/archive/$branch.tar.gz
tar -xzf $name.tar.gz
rm $name.tar.gz
mv ${name}-* $name

# Install
if [ $# -eq 0 ] || [ "$1" != "$vagrant_switch" ]; then
  sudo $name/selenium-setup.sh
else
  $name/vagrant-selenium-setup.sh
fi

# Clean up
rm -rf $name
