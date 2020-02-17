# Platform 6 Installation Guide

This repository contains [Platform 6](https://documentation.amalto.com/platform6/latest/)'s deployment scripts.
Before trying to install/deploy P6 instances, make sure you've signed up to Platform 6 [here](https://signup.console.platform6.io).

This guide contains all the resources you need to start deploying Platform 6.  You can get up and running quickly using docker and deploy an instance to your laptop.
You can use the terraform scripts provided to deploy Platform 6 to a major cloud provider in a resilient and production ready configuration.

Whatever your needs, this guide provides our current 'best practice' deployment information and configuration details for Platform 6. 

**Can't wait and don't want to read anymore...?**

**Use this [link](./docker-compose/README.md) and follow the simple instructions to deploy an instance on your desktop or laptop now.**

Types of deployment technology used in his guide:

- Docker: https://www.docker.com/
- Terraform: https://www.terraform.io/

Docker has long been the default deployment technology used for Platform 6.  It is a well used, well documented technology and allows straight forward deployment on everything from developers laptops to large cooperate servers.

As Platform 6 scales beyond small group servers, SLAs and guaranteed reliability become essential. When using Platform 6 in mission critical production environments we look to large cloud providers to deliver the services required.
Terraform allows us to provide you with predictable and repeatable deployment scripts to deliver Platform 6 infrastructure in the most common configurations on a variety of cloud service platforms. 

The use of our docker and/or terraform scripts are by no means the only ways to deploy Platform 6.  We hope that this guide contains sufficient examples to aid and inspire you to solve problems you face in your chosen deployment environment.

_Finally, if the prospect of managing and hosting Platform 6 instances is unattractive to you or your organisation then please contact us to discuss our managed services solutions; freeing you to concentrate 100% on building great apps with Platform 6._    
