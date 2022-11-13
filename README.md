# AWS Reference Architecture for Wordpress

[AWS Reference Architecture (Wordpress)](https://aws.amazon.com/blogs/architecture/wordpress-best-practices-on-aws/) with Terraform and Terragrunt Solutions

Cloudformation sloution is [there](https://github.com/aws-samples/aws-refarch-wordpress)

---

## Architecture Overview

![architecture-overview](docs/assets/aws-refarch-wordpress-v20171026.jpeg)


### Make Commands:

- bootstrap-remote-state: Bootstrap s3 bucket and dynamodb for remote state

- config: For saml2aws configuration

- login: Gettign new session

- deploy: ensure actions for terraform

### Useful terraform tools:

- [terratest](https://terratest.gruntwork.io/): Automated tests for your infrastructure code.

- [terragrunt](https://terragrunt.gruntwork.io/): DRY and maintainable Terraform code.

- [terracost](https://github.com/cycloidio/terracost): About Cloud cost estimation for Terraform in your CLI

- [tfsummarize](https://github.com/dineshba/tf-summarize): A command-line utility to print the summary of the terraform plan

- [tflint](https://github.com/terraform-linters/tflint): A Pluggable Terraform Linter

- [terrascan](https://github.com/tenable/terrascan): Detect compliance and security violations across Infrastructure as Code to mitigate risk before provisioning cloud native infrastructure.

- [tgenv](https://github.com/cunymatthieu/tgenv): Terragrunt version manager

- [tfenv](Terraform version manager): Terraform version manager

- [tfsec](https://github.com/aquasecurity/tfsec): Security scanner for your Terraform code

- [terramate](https://github.com/mineiros-io/terramate): Terramate is a tool for managing multiple Terraform stacks with support for change detection and code generation. Alternative to terraform


- [terraspace](https://terraspace.cloud/): It provides an organized structure, conventions over configurations, keeps your code DRY, and adds convenient tooling. TERRASPACE makes working with Terraform easier and more fun

### Folder Structures:

#### folder structure for `terragrunt`

```
├── modules
│   ├── instance
│   ├── rds
│   ├── security_group
│   └── vpc
├── stacks
│   ├── app
│   ├── vpc
│   └── instance
└── config
    └── terraform
        ├── backend.tf
        └── provider.tf
```

#### folder structure for `terraform`

```
├── modules
│   ├── instance
│   ├── rds
│   ├── security_group
│   └── vpc
├── main.tf
├── backend.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── dev.auto.tfvars
├── staging.auto.tfvars
└── prod.auto.tfvars
```


----

#### Inspired By Below Project(s)

- https://github.com/aleti-pavan/terraform-aws-wordpress
- https://github.com/pixelicous/terraform-aws-wordpress

