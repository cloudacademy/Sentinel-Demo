# Configures the policy to be checked with an advisory enforcement - Allows passing but will warn on fail
policy "kubernetes-namespace" {
  source            = "./kubernetes_namespace_check.sentinel"
  enforcement_level = "advisory"
}

# Imports a common-functions library
module "tfplan-functions" {
  source = "./common-functions/tfplan-functions/tfplan-functions.sentinel"
}