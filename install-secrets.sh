#!/bin/sh
#
# To be used in host system to copy secrets to guest vm
#

# Connectivity info for Linux VM
NIXADDR=${NIXADDR:-172.16.218.128}
NIXUSER=${NIXUSER:-akash}

echo "Copying secrets to $NIXADDR"

# SSH options that are used. These aren't meant to be overridden but are
# reused a lot so we just store them up here.
SSH_OPTIONS="-o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# GPG keyring
rsync -av -e "ssh ${SSH_OPTIONS}" \
	--exclude='.#*' \
	--exclude='S.*' \
	--exclude='*.conf' \
	$HOME/.gnupg/ $NIXUSER@$NIXADDR:~/.gnupg

# SSH keys
rsync -av -e "ssh ${SSH_OPTIONS}" \
	--exclude='environment' \
	$HOME/.ssh/ $NIXUSER@$NIXADDR:~/.ssh
