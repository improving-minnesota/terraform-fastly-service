# # This commented section represents using a module for reusability
# module "snippet-test" {
#   source = ""
# }
#
# locals {
#   snippets = concat(
#     module.snippet-test.data,
#   )
# }

locals {
  snippets = [
    {
      content  = "# Sample VCL Comment"
      name     = "Sample Snippet"
      priority = 100
      type     = "deliver"
    },
  ]
}
