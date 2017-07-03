set -exu

apk add bash curl

(echo $VAGRANT_PASSWORD; echo $VAGRANT_PASSWORD) | adduser -s /bin/ash $VAGRANT_USERNAME

mkdir -pm 700 /home/$VAGRANT_USERNAME/.ssh

curl -sSo /home/$VAGRANT_USERNAME/.ssh/authorized_keys 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'

chown -R $VAGRANT_USERNAME:$VAGRANT_USERNAME /home/$VAGRANT_USERNAME
chmod -R og-rwx /home/$VAGRANT_USERNAME/.ssh
