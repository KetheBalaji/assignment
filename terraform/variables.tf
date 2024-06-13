variable "aws_region" {
 description = "The AWS region to create resources in."
 type        = string
 default     = "us-east-1"
}
variable "instance_type" {
 description = "The type of instance to create."
 type        = string
 default     = "t2.micro"
}
variable "sshkey_name" {
  description = "SSH_Key Name."
 type        = string
 default     = "microservice"
}
variable "allowed_ssh_cidr" {
 description = "The CIDR block allowed to access via SSH."
 type        = string
 default     =  "0.0.0.0/0"
}