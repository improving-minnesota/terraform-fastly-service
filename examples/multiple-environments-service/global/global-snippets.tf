# # This commented section represents using a module for reusability
# module "snippet-test" {
#   source = ""
# }
#
# locals {
#   global_snippets = concat(
#     module.snippet-test.data,
#   )
# }

locals {
  global_snippets = [
    {
      content  = "# Sample VCL Comment"
      name     = "Sample Snippet"
      priority = 100
      type     = "deliver"
    },
  ]
}
