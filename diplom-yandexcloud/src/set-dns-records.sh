#!/bin/bash

domain=`grep dns_domain ./terraform/stage/terraform.tfvars|cut -f2 -d'"'`
ip=`yc compute instance get proxy --format json | jq -r '.network_interfaces | .[0].primary_v4_address.one_to_one_nat.address'`
name="nzakirov-ru"
for subdomain in `grep subdomain terraform/stage/terraform.tfvars|cut -f2  -d'='|cut -f2 -d'[' |cut  -f1 -d']'|tr  -d '"'|tr -d ','`
do
  if [ ${subdomain} == "@" ]
  then
    record=${domain}.
  else
    record=${subdomain}.${domain}.
  fi

  yc dns zone replace-records ${name} --record "${record} 60 A ${ip}" 
done

