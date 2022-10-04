#!/bin/bash

# Export secret variables
export TF_VAR_YC_SERVICE_ACCOUNT_KEY_FILE=~/.config/yandex-cloud/sa_nzakirovs/key.json
export TF_VAR_YC_STORAGE_ACCESS_KEY=`head -1 ~/.config/yandex-cloud/sa_nzakirovs/access.key`
export TF_VAR_YC_STORAGE_SECRET_KEY="`head -1 ~/.config/yandex-cloud/sa_nzakirovs/secret.key`"
export TF_VAR_YC_CLOUD_ID="`yc config get cloud-id`"
export TF_VAR_YC_FOLDER_ID="`yc config get folder-id`"
export TF_VAR_YC_TOKEN="`yc iam create-token`"

# Destroy stage

echo "# ======= Destroing stage... ========= #"
echo "# =======  Current path: " `pwd`
cd ./terraform/stage || return
terraform destroy -auto-approve
../../del-ssh-conf.sh

echo "# ======= Clearing ~/.ssh/known_hosts... ========= #"
ssh-keygen -f ~/.ssh/known_hosts -R "nzakirov.ru"
for ip in `grep value terraform/stage/output.json |cut -f4 -d'"'`
do
  echo $ip
  ssh-keygen -f ~/.ssh/known_hosts -R "${ip}"
done

echo "# ======= Restore DNSs... ========= #"
../../unset-dns.sh
#~/bin/mivpnup

# Destroy s3
echo "# ======= Destroing S3... ========= #"
echo "# =======  Current path: " `pwd`
cd ../s3 || return
terraform destroy -auto-approve
#echo "# ======= Deleting local files... ========= #"
#if [ -d .terraform ]
#then
#  rm -f -r .terraform
#fi
#if [ -f .terraform.lock.hcl ]
#then
#  rm -f .terraform.lock.hcl
#fi
#if [ -f .terraform.tfstate ]
#then
#  rm -f .terraform.tfstate
#fi
#if [ -f .terraform.tfstate.backup ]
#then
#  rm -f .terraform.tfstate.backup
#fi

echo "# ======= YC VPC network list... ========= #"
yc vpc network list
echo "# ======= YC VPC subnet list... ========= #"
yc vpc subnet list
echo "# ======= YC instance list... ========= #"
yc compute instance list
echo "# ======================================== #"
# Delete secret variables
unset TF_VAR_YC_SERVICE_ACCOUNT_KEY_FILE
unset TF_VAR_YC_STORAGE_ACCESS_KEY
unset TF_VAR_YC_STORAGE_SECRET_KEY
unset TF_VAR_YC_CLOUD_ID
unset TF_VAR_YC_FOLDER_ID
unset TF_VAR_YC_TOKEN


