#!/bin/bash

# Export secret variables
export TF_VAR_YC_SERVICE_ACCOUNT_KEY_FILE=~/.config/yandex-cloud/sa_nzakirovs/key.json
export TF_VAR_YC_STORAGE_ACCESS_KEY=`head -1 ~/.config/yandex-cloud/sa_nzakirovs/access.key`
export TF_VAR_YC_STORAGE_SECRET_KEY="`head -1 ~/.config/yandex-cloud/sa_nzakirovs/secret.key`"
export TF_VAR_YC_CLOUD_ID="`yc config get cloud-id`"
export TF_VAR_YC_FOLDER_ID="`yc config get folder-id`"
export TF_VAR_YC_TOKEN="`yc iam create-token`"

# Destroy s3
echo "# ======= Destroing S3... ========= #"
echo "# =======  Current path: " `pwd`
cd ../s3 || return
terraform destroy -auto-approve

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


