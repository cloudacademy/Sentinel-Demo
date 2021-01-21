policy "medium_policy" {
  source            = "./medium_policy.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "easy_policy" {
  source = "./easy_policy.sentinel"
  enforcement_level = "advisory"
}

policy "remote-easy_policy" {
    source = "git::https://github.com/tsarlewey/Sentinel-Demo.git//policies/sentinel/example_policies/easy_policy.sentinel"
    enforcement_level = "advisory"
}

policy "multiple_rules" {
  source            = "./multiple_rules.sentinel"
  enforcement_level = "hard-mandatory"
}

module "remote-tfplan-functions-latest" {
  source = "git::https://github.com/hashicorp/terraform-guides.git//governance/third-generation/common-functions/tfplan-functions/tfplan-functions.sentinel"
}

 module "local-tfplan-functions" {
   source = "../common-functions/tfplan-functions/tfplan-functions.sentinel"
 }
 
mock "time" {
  data = {
    now = {
      hour = 12
      minute = 00
    }
  }
}

global "work" {
  value = {
    weekday = {
      days = ["Monday", "Tuesday",
      "Wednesday", "Thursday", "Friday"]
    }
  }
}

param "tired" {
    value = "Yes"
}