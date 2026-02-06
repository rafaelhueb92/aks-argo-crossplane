terraform fmt # Format files
terraform init # -reconfigure for a different backend
export ARM_SUBSCRIPTION_ID="$(az account show --query id --output tsv)" # set the env
terraform plan