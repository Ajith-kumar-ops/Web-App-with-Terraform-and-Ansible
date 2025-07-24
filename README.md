# Web App with Terraform and Ansible

This project provisions an AWS EC2 instance using Terraform and configures it with Ansible to serve a custom web page via NGINX.

## Contents
- `main.tf` – Terraform configuration
- `inventory` – Ansible inventory file
- `site.yml` – Ansible playbook
- `index.html` – Web content

## How to Run

1. Run `terraform init && terraform apply`
2. Then run `ansible-playbook -i inventory site.yml`
3. Visit the EC2 public IP in your browser

## Cleanup

Run `terraform destroy` to terminate resources and avoid AWS charges.

Author AjithKumar!
