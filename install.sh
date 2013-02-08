#!/bin/sh

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

name=selenium-grid

branch=master
if [ $# -gt 0 ]; then
  branch=$1
fi

repo=Publero/$name
if [ $# -gt 1 ]; then
  repo=$2
fi

if [ $# -gt 2 ]; then
  echo "Usage: $0 [[<branch>] <repository>]" >&2
  exit 1
fi

# Download installation content & prepare
wget -O $name.tar.gz https://github.com/$repo/archive/$branch.tar.gz
tar -xzf $name.tar.gz
rm $name.tar.gz
mv ${name}-$branch $name

# Install
$name/selenium-setup.sh

# Clean up
rm -rf $name
