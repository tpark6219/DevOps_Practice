# Purpose

The purpose is to build a test environment to better understand how applications are run and systems are configured, using automation tools and Infrastructure as Code tools. 

# Terraform, Ansible, Jenkins, and Python. 

These are the tools that will be used to setup this test environment. Other tools may be used (E.g Chef, Puppet, Salt) but these are the ones used for this repository. 

### Terraform 

Terraform will be used to get the moving parts needed to host a very simple python application. You will need an AWS account with aws credentials. You will also need to generate a key pair (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html).

```
cat ~/.aws/credentials

ssh-keygen -y
```
This will show if your credentials have been exported, so that you can use terraform.

```
terraform plan

terraform apply
```

This will setup a private VPC(Staging Environment), with 3 public subnets and 3 private subnets to build a robust environment. 
Only 1 public subnet will be used for the python application. This also includes a security group that allows ssh, http/https and port 5000 from any IP Address. 

### Ansible

Ansible will be used to install all your dependencies and deploy the simple python application so it is ready to serve requests. 
In your inventory.txt file you will need your ownAWS EC2 IP Address listed, using the ec2-user. Password will not be needed for EC2 since you are using the AWS credentials.

```
E.g

[group_A]
52.91.176.173 ansible_user=ec2-user

[group_B]
52.91.176.174 ansible_user=ec2-user

```

There is also a deploy jenkins playbook that deploys jenkins to one of the EC2 instances. Jenkins will not redeploy jenkins if the playbook has already been run. 

```
ansible-playbook playbook.yml -i inventory.txt 
```
All three playbooks in the tasks folder will be run using the "include" option, where the database and web application will be deployed in the first EC2 instance and jenkins will be deployed in the second EC2 instance.

### Jenkins

Jenkins will be used to build an artifiact and store into a zipfile to be deployed if changes occur.
Currently this application redeploys when changes are made on git and commmited. 
ISSUE: There is only one build process in Jenkins that does this redeployment which is a monolithic application. 
SOLUTION: Have two separate build processes that has one build process zip up the merge that is done to git, and the other build process to deploy the application.

### Python (ON GOING)

Python (ON GOING) will be used to create a script that will backup the database files into a local driver or S3 bucket. 


