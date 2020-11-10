# barn_proving_ground

## Purpose
We are charged with building and maintaining a complex infrastructure that is deployed via code.  As such, it is imperative that everyone who will build or maintain the infrastructure demonstrate a proficiency in the core technologies prior to being granted access to the actual environment.  The BARN infrastructure provides a hosting environment to gain and demonstrate these proficiencies.

BARN is built with the following core technologies:
1.  AWS cloud environment
2.  Terraform
3.  Packer
4.  Puppet
5.  Scripts (BASH and Python)

In the event someone wants to perform the tasks when BARN is unavailable, all the following can be performed using the AWS free-tier (https://aws.amazon.com/free) with the exception of the step that adds an additional EBS volume to an EC-2.  It is good practice to shutdown instances and delete unused resources when not required to minimize charges that fall outside the free tier.

## Prerequisites
1.  Proving ground assumes basic proficiency in AWS which includes an understanding of and how to create, modify and delete the following through the AWS console: IAM roles, VPCs, Subnets, Routing Tables, Security Groups, NACLs, EC2s, EBS volumes, S3 buckets, Launch Configurations and Auto Scaling Groups.

2.  For those working on this prior to the availability of BARN developer workstations, you will need a workstation with Packer and Terraform installed on it.

## Hints
1.  When selecting a CentOS 7 AMI, select one that ***does not have CIS or STIG benchmarks***
2.  For those not confortable with SELinux, disable it on your EC2:
    - Log into the EC2
    - Elevate privileges: `$ sudo su -`
    - Edit `/etc/selinux/config`
    - Change the value of SELINUX to: `SELINUX=disabled`
    - Save and close the file
    - Reboot the EC2: `shutdown -r now`
3.  Google is your friend

## Tasks
The following tasks are designed to build upon the previous step:

1.  Use the AWS Console to create a Web Server using the latest CentOS 7 AMI
    - Visiting: http://<IP_of_WebServer> should display a default index.html page
    - Set-up two (2) Security Groups:
      1.  Restrict Inbound http
      2.  Restrict Inbound ssh (ideally to your test workstation)
    - Have the server perform a yum update when it first comes up


2.  Create packer (https://www.packer.io/) script(s) to automate building the above into an AMI


3.  Use puppet (https://puppet.com/docs/open-source-puppet/) via a cron to manage the following on the Web Server created in the previous task:
    - NOTE: The intent is NOT to build an entire Puppet Master / Client infrastructure.  Instead, execute Puppet using local modules.
      1.  Configuring NTP to point to google NTP servers
      2.  Install the latest version of python


4.  Update the packer scripts to:
    - Host the web site on a separate EBS volume
      1.  Provision the additional EBS volume via Packer
      2.  Install the index.html on the new EBS volume
      3.  Use Puppet to update the http configuration to direct traffic to the new EBS volume for web server content


5.  Create terraform (https://www.terraform.io/) script(s) to:
    - Deploy the infrastructure
      1.  Create the security groups
      2.  Create a Launch Configuration that references the AMI and has appropriate user data
      3.  Create an Autoscaling Group for the Launch Configuration with a minimum and desired count of 1


6.  Deploy a second EC-2 via terraform that can download the index.html from the web server deployed in the previous step
    - Enforce that the web server restricts access via http to a Security Group
    - Update terraform to create two new Instance Roles:
      1.  WebServer
          - Write to S3
          - Describe instances
      2.  Consumer
          - Read from S3
    - Update terraform to deploy a new S3 bucket with the following bucket policies:
      1.  Only allow the WebServer Instance Role to write to the bucket
      2.  Only allow the Consumer Instance Role to read from the bucket
    - Assign the web server the WebServer Instance Role
    - Assign the second EC-2 the Consumer Instance Role
    - Create a Python (https://docs.python.org/3/) script (using Python 3.6 or newer) that queries AWS to get the WebServer's IP address and write it to the S3 bucket; do NOT use the magic address.  This script will be installed on the WebServer and run as part of UserData
    - Create a bash script that reads the WebServer's IP address from the S3 bucket.  This script will be installed on the second EC-2 and run on a cron.  The Consumer EC-2 will use this data to construct the curl command to read the index.html from the WebServer.
    

## Next Steps
Upon successful completion of the final task, please perform the following steps in order:
1.  Commit your code to a private GitHub (https://github.com); there is no charge to create an account and repository
2.  Add the following GitHub users as Collaborators:
    - friedms (Marc F.)
    - mfmjos (David C.)
3.  Send an e-mail to the following to let them know you're ready for a code review:
    - marc@TechnologySystems.com
    - dacompton@gmail.com

Upon successful verification of the code you will be granted access to the infrastructure on the customer network.
