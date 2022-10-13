#!/bin/bash

yc compute instance list
yc compute instance stop monitoring 
yc compute instance stop runner 
yc compute instance stop gitlab 
yc compute instance stop db01 
yc compute instance stop db02 
yc compute instance stop app 
yc compute instance list
