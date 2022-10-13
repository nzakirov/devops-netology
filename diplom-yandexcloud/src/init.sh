#!/bin/bash

# Export secret variables
echo "# ====== Exporting YC credentials ... ==== #"
export TF_VAR_YC_SERVICE_ACCOUNT_KEY_FILE=~/.config/yandex-cloud/sa_nzakirovs/key.json
export TF_VAR_YC_STORAGE_ACCESS_KEY=`head -1 ~/.config/yandex-cloud/sa_nzakirovs/access.key`
export TF_VAR_YC_STORAGE_SECRET_KEY="`head -1 ~/.config/yandex-cloud/sa_nzakirovs/secret.key`"
export TF_VAR_YC_CLOUD_ID="`yc config get cloud-id`"
export TF_VAR_YC_FOLDER_ID="`yc config get folder-id`"
export TF_VAR_YC_TOKEN="`yc iam create-token`"


echo "# ===== Up VPN... ============ #"
wg-quick up wg0-client
# S3 init
echo "# ===== S3 initialisation ... ============ #"
cd terraform/s3/ || return
terraform init && terraform plan &&  terraform apply -auto-approve

# deployment infrastructure
echo "#===== Deployment infrastructure ... ==== #"
cd ../stage || return
terraform init -reconfigure \
      -backend-config "access_key=$TF_VAR_YC_STORAGE_ACCESS_KEY" \
      -backend-config "secret_key=$TF_VAR_YC_STORAGE_SECRET_KEY"
terraform workspace new stage
terraform init && terraform plan && terraform apply -auto-approve

terraform output -json > output.json
sleep 5
# add variables
export vm_app_private=$(< output.json jq -r '.vm_app_private | .value')
export vm_db01_private=$(< output.json jq -r '.vm_db01_private | .value')
export vm_db02_private=$(< output.json jq -r '.vm_db02_private | .value')
export vm_gitlab_private=$(< output.json jq -r '.vm_gitlab_private | .value')
export vm_monitoring_private=$(< output.json jq -r '.vm_monitoring_private | .value')
export vm_proxy_private=$(< output.json jq -r '.vm_proxy_private | .value')
export vm_runner_private=$(< output.json jq -r '.vm_runner_private | .value')
# domain availability check
echo "# ===== Down VPN... ============ #"
wg-quick down wg0-client

../../set-dns.sh
sleep 3
(( count = 10 ))
while [[ $count -ne 0 ]] ; do
    ping -c 1 nzakirov.ru 
    ping_result=$?
    if [[ $ping_result -eq 0 ]] 
    then
        (( count = 1 ))
    else
        sleep 5
    fi
    (( count-- ))
done

if [[ $ping_result -eq 0 ]]  
then
    echo "БЕЗ БУЛДЫРАБЫЗ!!! Host is available"
else
    ../../unset-dns.sh
    exit
fi
cat ../../ssh-config.txt >> ~/.ssh/config
echo "# ======= YC VPC network list... ========= #"
yc vpc network list
echo "# ======= YC VPC subnet list... ========= #"
yc vpc subnet list
echo "# ======= YC instance list... ========= #"
yc compute instance list
echo "# ======================================== #"

# start ansible
cd ../../ansible || return
envsubst < "hosts.template" > "hosts"
sleep 7
#../stop_instances.sh
ansible-playbook playbook.yml -i hosts

# return to src 
cd ../


