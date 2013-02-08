#!/bin/sh

BOX_TITLE="selenium_box"
BOX_URL="http://cloud-images.ubuntu.com/quantal/current/quantal-server-cloudimg-vagrant-amd64-disk1.box"

vagrant box add $BOX_TITLE $BOX_URL
vagrant init $BOX_TITLE
vagrant up

HOST=$(vagrant ssh-config | grep -i hostname | awk '{print $2}')
PORT=$(vagrant ssh-config | grep -i port | awk '{print $2}')

echo 'mkdir ~/selenium' | vagrant ssh
sshpass -p 'vagrant' scp -o StrictHostKeychecking=no -P $PORT ./selenium-setup.sh vagrant@$HOST:~/selenium/
sshpass -p 'vagrant' scp -r -o StrictHostKeychecking=no -P $PORT ./config vagrant@$HOST:~/selenium/
sshpass -p 'vagrant' scp -r -o StrictHostKeychecking=no -P $PORT ./services vagrant@$HOST:~/selenium/
echo 'cd ~/selenium; ./selenium-setup.sh' | vagrant ssh
