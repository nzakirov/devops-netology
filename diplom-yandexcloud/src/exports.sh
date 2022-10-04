#!/bin/bash

export TF_VAR_YC_SERVICE_ACCOUNT_KEY_FILE=~/.config/yandex-cloud/sa_nzakirovs/key.json
export TF_VAR_YC_STORAGE_ACCESS_KEY=`head -1 ~/.config/yandex-cloud/sa_nzakirovs/access.key`
export TF_VAR_YC_STORAGE_SECRET_KEY="`head -1 ~/.config/yandex-cloud/sa_nzakirovs/secret.key`"
export TF_VAR_YC_CLOUD_ID="`yc config get cloud-id`"
export TF_VAR_YC_FOLDER_ID="`yc config get folder-id`"
export TF_VAR_YC_TOKEN="`yc iam create-token`"
