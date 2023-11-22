variable "vpc-id" {
  type = string
}

variable "internet-cidr" {
  description = "cidr block for internet"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ubuntu-ami" {
  type = string
}

variable "ssh-key-name" {
  type    = string
  default = "keypair-l2"
}

variable "private-ip" {
  type    = string
  default = "172.20.7.47"
}

variable "database-subnet-ids" {
  type = list(string)
}

variable "nat-sg-id" {
  type = string
}

variable "bastion-sg-id" {
  type = string
}

variable "backend-subnet-cidrs" {
  type = list(string)
}
