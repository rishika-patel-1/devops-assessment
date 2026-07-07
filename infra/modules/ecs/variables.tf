variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "ECS Security Group ID"
  type        = string
}

variable "container_image" {
  description = "Docker image"
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "Container Port"
  type        = number
  default     = 80
}

variable "target_group_arn" {
  description = "ALB Target Group ARN"
  type        = string
}