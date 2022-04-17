terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.27.0"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
  token = var.token
}

# Create a Linode
resource "linode_instance" "bugbountybox" {
  image     = var.image
  label     = var.label
  region    = var.region
  type      = var.type
  root_pass = var.root_pass
}

# Create an Ansible playbook from a template file
resource "local_file" "bugbountybox_setup" {
  content = templatefile("./templates/playbook.tmpl",
    {
      ip_address = linode_instance.bugbountybox.ip_address
    }
  )
  file_permission = "0640"
  filename        = "../ansible/playbook.yml"
}

# Create an Ansible config from a template file. 
resource "local_file" "ansible_config" {
  content = templatefile("./templates/ansible.tmpl",
    {
      remote_user = "root"
    }
  )
  file_permission = "0640"
  filename        = "../ansible/ansible.cfg"
}

# Create an Ansible inventory from a template file
resource "local_file" "ansible_inventory" {
  content         = linode_instance.bugbountybox.ip_address
  file_permission = "0640"
  filename        = "../ansible/hosts"
}
