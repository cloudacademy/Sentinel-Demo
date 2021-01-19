policy "kubernetes-namespace" {
  source            = "./kubernetes_namespace_check.sentinel"
  enforcement_level = "advisory"
}