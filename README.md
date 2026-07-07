# DevOps Assessment - Terraform AWS Infrastructure

## Project Overview

This project provisions AWS infrastructure on AWS using reusable Terraform modules.

The infrastructure is organized into reusable modules and separate environments for Development and Production following Infrastructure as Code (IaC) best practices.

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
├── .github/
│   └── workflows/
│       └── terraform.yml
├── infra/
│   ├── envs/
│   │   ├── dev/
│   │   └── prod/
│   └── modules/
│       ├── network/
│       ├── security/
│       ├── alb/
│       ├── ecs/
│       └── rds/
├── migrations/
├── scripts/
├── seed/
├── docker-compose.yml
├── .gitignore
└── README.md
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

### Application Load Balancer (ALB)
- Application Load Balancer
- Target Group
- HTTP Listener

### ECS
- ECS Cluster
- Task Definition
- ECS Service
- CloudWatch Log Group
- IAM Execution Role

### RDS
- PostgreSQL Database
- DB Subnet Group

---

## Environments

Two separate environments are provided:

- Development (`infra/envs/dev`)
- Production (`infra/envs/prod`)

Each environment contains:

- `provider.tf`
- `backend.tf`
- `main.tf`
- `variables.tf`
- `terraform.tfvars`
- `outputs.tf`

---

## Prerequisites

- Terraform
- AWS CLI
- AWS Account
- Configured AWS Credentials

---

## Commands

Initialize Terraform

```bash
terraform init
```

Validate configuration

```bash
terraform validate
```

Preview infrastructure

```bash
terraform plan
```

Deploy infrastructure

```bash
terraform apply
```

Destroy infrastructure

```bash
terraform destroy
```

---

## Features

- Modular Terraform Architecture
- Multi-Environment Support (Dev & Prod)
- ECS Fargate
- Application Load Balancer
- PostgreSQL RDS
- CloudWatch Logging
- Security Groups
- Infrastructure as Code (IaC)

---

## Notes

This repository was created as part of a DevOps Terraform Assessment.

The infrastructure configuration was verified using:

- `terraform validate`
- `terraform plan`

AWS resources were **not applied** to avoid unnecessary cloud charges.

---

## Author

**Rishika Patel**