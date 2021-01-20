policy "kubernetes-namespace" {
  source            = "./kubernetes_namespace_check.sentinel"
  enforcement_level = "advisory"
}

module "tfplan-functions" {
  source = "policies/sentinel/common-functions/tfplan-functions/tfplan-functions.sentinel"
}