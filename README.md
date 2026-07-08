# DevOps Assessment – Terraform AWS Infrastructure

## Project Overview

This project provisions AWS infrastructure using reusable Terraform modules following Infrastructure as Code (IaC) best practices.

The infrastructure is designed with a modular architecture and supports separate Development and Production environments for better scalability, maintainability, and reusability.

---

## Architecture

```
                   Internet
                       │
          Application Load Balancer
                       │
             ECS Fargate Service
                       │
            PostgreSQL RDS Database
```

---

## AWS Services Used

- Amazon VPC
- Public & Private Subnets
- Internet Gateway
- Route Tables
- Security Groups
- Application Load Balancer (ALB)
- Amazon ECS Fargate
- Amazon RDS PostgreSQL
- CloudWatch Logs
- IAM Roles

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

## Terraform Modules

| Module | Purpose |
|---------|---------|
| Network | Creates VPC, Public & Private Subnets, Internet Gateway and Route Tables |
| Security | Creates Security Groups for ALB, ECS and RDS |
| ALB | Creates Application Load Balancer, Target Group and Listener |
| ECS | Creates ECS Cluster, Task Definition, Service, IAM Role and CloudWatch Log Group |
| RDS | Creates PostgreSQL Database and DB Subnet Group |

---

## Environments

Two independent environments are configured:

- Development (`infra/envs/dev`)
- Production (`infra/envs/prod`)

Each environment contains:

- provider.tf
- backend.tf
- main.tf
- variables.tf
- terraform.tfvars
- outputs.tf

---

## Prerequisites

- Terraform >= 1.5
- AWS CLI
- AWS Account
- Configured AWS Credentials

---

## Deployment Steps

### Clone Repository

```bash
git clone https://github.com/rishika-patel-1/devops-assessment.git
cd devops-assessment
```

### Navigate to Environment

```bash
cd infra/envs/dev
```

### Initialize Terraform

```bash
terraform init
```

### Format Terraform Code

```bash
terraform fmt -recursive
```

### Validate Configuration

```bash
terraform validate
```

### Preview Infrastructure

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

### Destroy Infrastructure

```bash
terraform destroy
```

---

## Features

- Modular Terraform Architecture
- Infrastructure as Code (IaC)
- Multi-Environment Support (Development & Production)
- ECS Fargate Deployment
- Application Load Balancer
- PostgreSQL RDS Database
- CloudWatch Logging
- Secure Networking
- Security Groups
- Reusable Terraform Modules

---

## Validation

The Terraform configuration has been verified using:

- terraform fmt
- terraform validate
- terraform plan

The infrastructure configuration is deployment-ready.

To avoid unnecessary AWS charges, cloud resources were intentionally not created using `terraform apply`.

---

## Assumptions

- AWS CLI is configured with valid credentials.
- Terraform version 1.5 or above is installed.
- AWS Region is configured appropriately.
- Required IAM permissions are available.

---

## Future Enhancements

- HTTPS using AWS Certificate Manager (ACM)
- Auto Scaling for ECS Services
- Remote Terraform Backend using S3 and DynamoDB
- GitHub Actions CI/CD Deployment
- CloudWatch Monitoring and Alarms

---

## Author

**Rishika Patel**

DevOps Engineer

GitHub: https://github.com/rishika-patel-1