#!/usr/bin/env python3

import socket
import os
import json
import yaml
import argparse

prev_hosts = []
curr_hosts = []

parser = argparse.ArgumentParser(description='A tutorial of hosts_ip!')
parser.add_argument("--ftype",
                    choices=["json", "yaml"],
                    default="json", type=str, help="File type")
args = parser.parse_args()
ft = args.ftype
hosts_file = "hosts_list"
if ft == "json":
    with open(f"{hosts_file}.json", "r") as fhosts:
        prev_hosts = json.load(fhosts)
else:
    with open(f"{hosts_file}.yaml", "r") as fhosts:
        prev_hosts = yaml.safe_load(fhosts)

# Сохранение в файл результатов предыдущей проверки
os.system(f"cp {hosts_file}.json {hosts_file}.json.`date +%Y%m%d%H%M%S`")
os.system(f"cp {hosts_file}.yaml {hosts_file}.yaml.`date +%Y%m%d%H%M%S`")

# Проверка текущего значения IP и соответствия последней проверке
for item in prev_hosts:
    curr_dict = {}
    for host in item:
        curr_ip = socket.gethostbyname(host)
        curr_dict[host] = curr_ip
        curr_hosts.append(curr_dict)
        if curr_ip == item[host]:
            print(f'{host} - {curr_ip}')
        else:
            print(f'[ERROR] {host} IP mismatch: {item[host]} {curr_ip}')

with open(f"{hosts_file}.json", "w") as fhosts:
    json.dump(curr_hosts, fhosts)

with open(f"{hosts_file}.yaml", "w") as fhosts:
    yaml.dump(curr_hosts, fhosts)

