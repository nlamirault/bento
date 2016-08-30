set -exu

apk add bash curl

adduser -D vagrant
echo "vagrant:vagrant" | chpasswd

mkdir -pm 700 /home/vagrant/.ssh

curl -sSo /home/vagrant/.ssh/authorized_keys 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'

chown -R vagrant:vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh
