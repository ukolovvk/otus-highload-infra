terraform init -> terraform plan -> terraform apply

AUTH ENV:<br>
export YC_TOKEN=$(yc iam create-token)<br>
export YC_CLOUD_ID=$(yc config get cloud-id)<br>
export YC_FOLDER_ID=$(yc config get folder-id)<br>

![Alt text](image.png)

![Alt text](image-1.png)