## Usage

### Environment Variables
`export TF_VAR_fastly_api_key=<fastly-api-token>`

Optionally, (otherwise dev base_domain_name defaults to `user.mydomain.com`):
`export TF_VAR_base_domain_name=<base-domain-name>`

Optionally. set the `base_domain_prefix` variable located in the `environment.auto.tfvars` file

### Commands
```
terragrunt --non-interactive init --all -reconfigure
terragrunt --non-interactive plan --all
terragrunt --non-interactive apply --all --queue-include-dir dev
terragrunt --non-interactive apply --all --queue-include-dir production
terragrunt destroy --all
```

## Terraform
See environment folder for details
