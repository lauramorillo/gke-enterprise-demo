resource "google_gke_hub_feature" "policycontroller" {
  name = "policycontroller"
  location = "global"
  fleet_default_member_config {
    policycontroller {
      policy_controller_hub_config {
        install_spec = "INSTALL_SPEC_ENABLED"
        policy_content {
          bundles {
            bundle = "policy-essentials-v2022"
          }
          template_library {
            installation = "ALL"
          }
        }
        audit_interval_seconds = 30
        referential_rules_enabled = true
      }
    }
  }
}