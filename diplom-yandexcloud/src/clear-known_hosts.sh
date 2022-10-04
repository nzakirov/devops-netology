#!/bin/bash

ssh-keygen -f ~/.ssh/known_hosts -R "nzakirov.ru"
for ip in `grep value terraform/stage/output.json |cut -f4 -d'"'`
do
  echo $ip
  ssh-keygen -f ~/.ssh/known_hosts -R "${ip}"
done

