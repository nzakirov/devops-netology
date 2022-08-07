#!/bin/sh

docker-compose up -d
ansible-playbook -i ./playbook/inventory/prod.yml ./playbook/site.yml --ask-vault-password
docker-compose down



