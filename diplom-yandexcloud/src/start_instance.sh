#!/bin/bash

yc compute instance list
yc compute instance start proxy 
yc compute instance start db01 
yc compute instance start db02 
yc compute instance start app 
yc compute instance start gitlab 
yc compute instance start runner 
#yc compute instance start monitoring 

yc compute instance list
./set-dns-records.sh
yc dns zone list-records --name  nzakirov-ru
