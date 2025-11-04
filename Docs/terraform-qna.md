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
```

### Apply/plan specific module and passing variable value
```bash
terraform plan -var="enable_guardDuty=true" -target=module.guardDuty
terraform apply -var="enable_guardDuty=true" -target=module.guardDuty
```

<!---check aws vpc flow logs related things------>

### Check vpc flow logs from ec2 from AWS Cli
```bash
Anurags-Laptop:aws anuragpandit$ aws ec2 describe-flow-logs --query "FlowLogs[*].{FlowLogId:FlowLogId,ResourceId:ResourceId,LogDestination:LogDestination,DeliverLogsStatus:DeliverLogsStatus}"

[
    {
        "FlowLogId": "fl-0eea770407f60e018",
        "ResourceId": "vpc-0f45422f4647bc003",
        "LogDestination": "arn:aws:s3:::centralized-logs-a3811a20/vpcflow/",
        "DeliverLogsStatus": "SUCCESS"
    }
]

```

### Check path where vpc flow logs getting stored in s3 bucket
```bash
Anurags-Laptop:aws anuragpandit$ aws s3 ls s3://centralized-logs-a3811a20/ --recursive | head
2025-11-04 10:04:55          0 vpcflow/AWSLogs/021607743958/
2025-11-04 10:15:52       1851 vpcflow/AWSLogs/021607743958/vpcflowlogs/us-east-1/2025/11/04/021607743958_vpcflowlogs_us-east-1_fl-0eea770407f60e018_20251104T0440Z_ef9d63a8.log.gz
2025-11-04 10:20:52       1384 vpcflow/AWSLogs/021607743958/vpcflowlogs/us-east-1/2025/11/04/021607743958_vpcflowlogs_us-east-1_fl-0eea770407f60e018_20251104T0445Z_7a6369fb.log.gz
2025-11-04 10:15:52        234 vpcflow/AWSLogs/021607743958/vpcflowlogs/us-east-1/2025/11/04/021607743958_vpcflowlogs_us-east-1_fl-0eea770407f60e018_20251104T0445Z_b9b404cc.log.gz
2025-11-04 10:20:52        380 vpcflow/AWSLogs/021607743958/vpcflowlogs/us-east-1/2025/11/04/021607743958_vpcflowlogs_us-east-1_fl-0eea770407f60e018_20251104T0450Z_d774b35c.log.gz
```