# AWS CLI Installation

```bash
brew install awscli

```

## awscli verification 

```bash
aws --version
aws help
aws configure list
```

```bash
aws-cli/2.16.5 Python/3.11.8 Darwin/24.4.0 exe/x86_64

      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key                <not set>             None    None
secret_key                <not set>             None    None
    region                <not set>             None    None
```

## Enabling aws auto completion

```bash
complete -C '/usr/local/bin/aws_completer' aws

#make it persistant
echo "complete -C '/usr/local/bin/aws_completer' aws" >> ~/.bash_profile

source  ~/.bash_profile
```

## Create AWS IAM User for Terraform

#### IAM->Users->Add Users
#### Username=Terraform
#### Permissions->Attach existing policies directly -> Administrator Access
#### Add tags
#### Review -> Create User
#### Copy Access ID and Secret Access Key

## Configure AWS CLI

```bash
Anurags-Laptop:cloud-splunk-automation-lab anuragpandit$ aws configure
```

## Verify

```bash
Anurags-Laptop:cloud-splunk-automation-lab anuragpandit$ aws sts get-caller-identity
{
    "UserId": "AIDAQKB7MAHLEJWSMFLPR",
    "Account": "021607743958",
    "Arn": "arn:aws:iam::021607743958:user/terraform"
}
```