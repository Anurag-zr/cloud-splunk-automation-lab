## Terraform QnA

### Command to initialize terraform
```bash
terraform init
```

### Command to see how and what resource going to be provisioned
```bash
terraform plan
```
**this command does not deploy any resorce**

### Command to deploy resources
```bash
terraform apply 
terraform apply --auto-approve
```

### Command to destroy resources
```bash
terraform destroy
```

### Apply or Destroy specific modules of terraform
```bash
terraform apply -target=module.guardDuty
terraform destroy -target=module.cloudtrail


