# DevOps Assessment - Terraform AWS Infrastructure

## Project Overview

This project provisions AWS infrastructure using reusable Terraform modules.

The infrastructure is organized into reusable modules and separate environments (Development and Production).

---

## Architecture

```
                Internet
                    |
             Application Load Balancer
                    |
              ECS Fargate Service
                    |
             PostgreSQL RDS Database
```

---

## Project Structure

```
devops-assessment/
│
├── README.md
├── .gitignore
│
└── infra/
    ├── modules/
    │   ├── network/
    │   ├── security/
    │   ├── alb/
    │   ├── ecs/
    │   └── rds/
    │
    └── envs/
        ├── dev/
        └── prod/
```

---

## Modules

### Network
- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- Route Tables

### Security
- ALB Security Group
- ECS Security Group
- RDS Security Group

### ALB
- Application Load Balancer
- Target Group
- HTTP Listener

### ECS
- ECS Cluster
- Task Definition
- ECS Service
- CloudWatch Logs
- IAM Role

### RDS
- PostgreSQL Database
- DB Subnet Group

---

## Environments

- Development (`infra/envs/dev`)
- Production (`infra/envs/prod`)

Each environment has its own:

- provider.tf
- backend.tf
- variables.tf
- terraform.tfvars
- outputs.tf
- main.tf

---

## Prerequisites

- Terraform
- AWS CLI
- AWS IAM User
- AWS Credentials configured

---

## Initialize Terraform

```bash
terraform init
```

## Validate

```bash
terraform validate
```

## Preview Infrastructure

```bash
terraform plan
```

## Deploy Infrastructure

```bash
terraform apply
```

## Destroy Infrastructure

```bash
terraform destroy
```

---

## Features

- Reusable Terraform Modules
- Multi-Environment Support
- ECS Fargate
- Application Load Balancer
- PostgreSQL RDS
- CloudWatch Logging
- Security Groups
- Infrastructure as Code (IaC)

---

## Notes

This repository was created as part of a DevOps Terraform Assessment.

The infrastructure was validated using:

- terraform validate
- terraform plan

AWS resources were **not applied** to avoid unnecessary cloud charges.

---

## Author

**Rishika Patel**