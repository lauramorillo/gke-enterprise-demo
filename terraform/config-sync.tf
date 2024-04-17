resource "google_gke_hub_feature" "config_feature" {
  name     = "configmanagement"
  location = "global"
  fleet_default_member_config {
    configmanagement {
      config_sync {
        source_format = "unstructured"
        git {
          sync_repo   = "https://github.com/lauramorillo/gke-enterprise-demo"
          sync_branch = "main"
          secret_type = "none"
          policy_dir  = "app"
        }
      }
    }
  }

  # This dependency ensures that the feature is created after the service is enabled
  depends_on = [
    google_project_service.services
  ]
}
