# AWS Infrastructure Deployment

This repository provides CloudFormation templates and diagrams for deploying a demo AWS environment in the **ap-northeast-1** region, including:

- **VPC** with public/private subnets across AZs 1a & 1c
- **EC2** instance (`t2.micro`) running an application on port 8080
- **RDS** MySQL (`db.t4g.micro`) in private subnets
- **ALB** (internet-facing) forwarding HTTP traffic to EC2

## Diagrams

![Current Infra Diagram](diagrams/infra-diagram_v2.svg)
