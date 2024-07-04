locals {
  tags = {
    COST_CENTER  = "Shared"
    PROJECT_NAME = "Namada CI"
    ENVIRONMENT  = terraform.workspace
  }
}