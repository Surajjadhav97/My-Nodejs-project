# My-Nodejs-project
Complete CI/CD of Node.js Webserver using Jenkins, Docker, Terraform and AWS

Phase 1: Setup AWS infra Using Terraform

  step 1: Install Terraform
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
  sudo yum -y install terraform

  step 2: Run the Terrform.tf file
  Terraform init 
  Terraform plan (Dry run) 
  Terraform apply
  
