#!/bin/sh

if [ $# -gt 1 ]; then
  echo "Usage: $0 [ --vagrant ]" >&2
  exit 1
fi

if [ $# -eq 1 ] && [ "$1" != "--vagrant" ]; then
  echo "Usage: $0 [ --vagrant ]" >&2
  exit 1
fi

branch=master
name=selenium
repo=Publero/$name

# Download installation content & prepare
wget -O $name.tar.gz https://github.com/$repo/archive/$branch.tar.gz
tar -xzf $name.tar.gz
rm $name.tar.gz
mv ${name}-${branch} $name

# Install
if [ $# -eq 1 ] && [ $1 == "--vagrant" ]; then
  $name/vagrant-selenium-setup.sh
else
  sudo $name/selenium-setup.sh
fi

# Clean up
rm -rf $name
