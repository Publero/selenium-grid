#!/bin/sh

BOX_TITLE="selenium_box"
BOX_URL="http://cloud-images.ubuntu.com/quantal/current/quantal-server-cloudimg-vagrant-amd64-disk1.box"

vagrant box add $BOX_TITLE $BOX_URL
vagrant init $BOX_TITLE
vagrant up

command -v sshpass >/dev/null 2>&1 || {
  echo "sshpass is not installed - installing now" >&2
  sudo apt-get -y install sshpass
}

HOST=$(vagrant ssh-config | grep -i hostname | awk '{print $2}')
PORT=$(vagrant ssh-config | grep -i port | awk '{print $2}')

name=selenium-grid

cd $name

echo "cd ~/$name >/dev/null 2>&1 || mkdir ~/$name" | vagrant ssh
sshpass -p 'vagrant' scp -o StrictHostKeychecking=no -P $PORT ./selenium-setup.sh vagrant@$HOST:~/$name/
sshpass -p 'vagrant' scp -r -o StrictHostKeychecking=no -P $PORT ./config vagrant@$HOST:~/$name/
sshpass -p 'vagrant' scp -r -o StrictHostKeychecking=no -P $PORT ./services vagrant@$HOST:~/$name/
echo "cd ~/$name; ./selenium-setup.sh" | vagrant ssh
