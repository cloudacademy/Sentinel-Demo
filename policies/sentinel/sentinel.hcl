policy "kubernetes-namespace" {
  source            = "./kubernetes_namespace_check.sentinel"
  enforcement_level = "advisory"
}

module "plan" {
  source = common-functions/tfplan-functions-sentinel
}