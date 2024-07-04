# Earthly Terraform

Setup a earthly satellite on AWs following the instruction [here](https://docs.earthly.dev/earthly-cloud/satellites/self-hosted).

### Requirements

- An AWS `eip` id and ip
- An AWS VPC
- An AWS EC2 keyname
- Earthly token / organziation

### How to run

- `terraform init`
- `terraform plan`
- `terraform apply`