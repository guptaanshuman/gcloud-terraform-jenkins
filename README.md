## install jenkins on gcloud with terraform

 Setup you private gcloud creds before running the script :

```
provider "google" {
credentials = "${file("account.json")}"   #Path of authentication key json file
project = " "			# Project ID
region = "us-central1"
}
```

##### Steps to initialize this project

Run following commands to run & test Terraform scripts :

- terraform init          (To initialize the project)
- terraform plan        (To check the changes to be made by Terraform on azure )
- terraform apply       (To apply the changes to azure)


To verify Jenkins , open the public ip in browser
```gcloud_public:8080```    
& get Jenkins Admin password by SSHing the VM
