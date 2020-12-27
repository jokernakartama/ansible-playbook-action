#!/bin/sh

key_path="~/ansible_ssh_key"
config_path="~/.ansible.cfg"
inventory_path="~/ansible_hosts"
password_path="~/ansible_vault_password"

if [ ! -z "$INPUTS_SSH_KEY" ]
then
    echo "$INPUTS_SSH_KEY" > $key_path
    chmod 0600 $key_path
fi

if [ ! -z "$INPUTS_CONFIG" ]
then
    echo "$INPUTS_CONFIG" > $config_path
fi

if [ ! -z "$INPUTS_INVENTORY" ]
then
    echo "$INPUTS_INVENTORY" > $inventory_path
fi

if [ ! -z "$INPUTS_PASSWORD" ]
then
    echo "$INPUTS_PASSWORD" > $password_path
fi

ansible-playbook $@ \
    $([ ! -z "$INPUTS_SSH_KEY" ] && echo "--private-key" $key_path) \
    $([ ! -z "$INPUTS_INVENTORY" ] && echo "--inventory" $inventory_path) \
    $([ ! -z "$INPUTS_PASSWORD" ] && echo "--vault-password-file" $password_path)
