
# My Node.js Application

CI/CD of a Node.js Application using Jenkins, Docker, terraform & AWS


## Installation
step 1:Install Terraform

```bash
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
  sudo yum -y install Terraform
  
  Terraform Init 
  Terraform plan
  Terraform apply
## Setup Jenkins

 sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
 sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
 yum install fontconfig java-17-openjdk
  yum install jenkins
  systemctl start jenkins.service




## Node.js Webserver

mkdir nodejs-web-server
cd nodejs-web-server
npm init -y
npm install express --save
npm start

create a index.js file
node index.js #to run the application



## Docker Containerisation

create a Dockerfile

# Dockerfile
FROM node:14

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
  

docker build -t nodejs-web-server .
docker run -p 3000:3000 -d nodejs-web-server





##  CI/CD Implementation with Jenkins:

To deploy this project run

pipeline {
  agent any

  environment {
						
		url = "https://github.com/Surajjadhav97/My-Nodejs-project.git"
  }
  
 stages {  
       stage ("ClONE_PROJECT"){
								
	 steps {
		sh "rm -rf *"
		sh "git clone $url"
							
		}
       }

    stage ("Node.js"){
	    steps{
		 sh "npm install express --save"
		 sh "npm start"
		 sh "nohup node index.js > output.log 2>&1 &" 
	    }
       }

    stage('Build') {
          steps {
          script {
          sh "docker build -t <image-name> ."
	  sh "docker run -d -p 3000:3000 <your-image-name>"
	  
        }
      }
    }

   
   stage('Deploy') {
      steps {
        script {
          docker.withRegistry('https://hub.docker.com/u/surajjadhav97', 'docker-credentials') {
            docker.image('nodejs-web-server').push()
          }
        }
      }
    }
  }


```
Configure Docker credentials in Jenkins:

In Jenkins, go to "Manage Jenkins" > "Manage Credentials" > "Jenkins" (or "Global") > "Add Credentials" to add your Docker Hub or other registry credentials.

Trigger your Jenkins pipeline manually or let it be triggered automatically when changes are pushed to your version control system.
