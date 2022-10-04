#!/bin/bash

begin=`grep -n "^## Begin netology-diplom" ~/.ssh/config|cut -f1 -d':'`
end=`grep -n "^## End netology-diplom" ~/.ssh/config|cut -f1 -d':'`
sed -i "${begin},${end}d" ~/.ssh/config

