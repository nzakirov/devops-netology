#!/usr/bin/env python3

import socket
import os
import json

prev_hosts = []
curr_hosts = []

# Чтение из файла в словарь результатов последней проверки. Ключ - URL, значение IP
#file_hosts = open('hosts_list', 'r', encoding='utf-8')
#for line in file_hosts:
#    inputStr  = list(line.split(' '))
#    url = inputStr[0]
#    ip = inputStr[1].replace('\n', '')
#    
#    if url not in prev_hosts.keys():
#        prev_hosts[url] = ip 
#file_hosts.close()
#
with open("hosts_list.json", "r") as hosts_file:
    prev_hosts = json.load(hosts_file)

# Сохранение в файл результатов предыдущей проверки
os.system('cp hosts_list.json hosts_list.json.`date +%Y%m%d%H%M%S`')

# Проверка текущего значения IP и соответствия последней проверке
#file_hosts = open('hosts_list', 'w', encoding='utf-8')
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
    #    file_hosts.write(host + ' ' + curr_ip + '\n')
    #file_hosts.close()

with open("hosts_list.json", "w") as hosts_file:
    json.dump(curr_hosts, hosts_file)

