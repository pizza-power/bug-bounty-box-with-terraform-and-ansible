variable "LINODE_API_TOKEN" {
  type        = string
  description = "Linode APIv4 token."
  sensitive   = true
}

variable "image" {
  type        = string
  description = "Image to use for your VM."
  default     = "linode/ubuntu20.04"
}

variable "label" {
  type        = string
  description = "Label to give your VM."
}

variable "region" {
  type        = string
  description = "Region where the VM will be created."
}

variable "ROOT_PASS" {
  type        = string
  description = "Password for the root account on this VM."
  sensitive   = true
}

variable "type" {
  description = "Your Linode's plan type."
  # You can initialize variables here instead of the tfvars file. 
  default = "g6-standard-1"
}
