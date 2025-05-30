terraform {
  source = "${get_terragrunt_dir()}/../global"
}

include "root" {
  path = find_in_parent_folders("terragrunt-root.hcl")
}
