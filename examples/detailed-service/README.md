## Usage

### Environment Variables
`export TF_VAR_fastly_api_key=<fastly-api-token>`

Optionally, (otherwise base_domain_name defaults to `mydomain.com`):
`export TF_VAR_base_domain_name=<base-domain-name>`

Optionally. set the `base_domain_prefix` variable located in the `environment.auto.tfvars` file

### Commands
```
terraform init
terraform plan
terraform apply --auto-approve
terraform destroy
```

## Terraform
<!-- BEGIN_TF_DOCS -->


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fastly_service"></a> [fastly\_service](#module\_fastly\_service) | ../.. | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_domain_name"></a> [base\_domain\_name](#input\_base\_domain\_name) | Base domain prefix | `string` | `"user-mydomain.com"` | no |
| <a name="input_base_domain_prefix"></a> [base\_domain\_prefix](#input\_base\_domain\_prefix) | Base domain prefix | `string` | n/a | yes |
| <a name="input_fastly_api_key"></a> [fastly\_api\_key](#input\_fastly\_api\_key) | The Fastly API key | `string` | n/a | yes |
<!-- END_TF_DOCS -->
