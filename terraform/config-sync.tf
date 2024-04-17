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

/*# This membership attaches the configmanagement feature to cluster-a
resource "google_gke_hub_feature_membership" "config_feature_cluster_a" {
  location   = "global"
  feature    = google_gke_hub_feature.config_feature.name
  membership = google_gke_hub_membership.membership-cluster-a.membership_id
  configmanagement {
    version = "1.6.2"
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

# This membership attaches the configmanagement feature to cluster-b
resource "google_gke_hub_feature_membership" "config_feature_cluster_b" {
  location   = "global"
  feature    = google_gke_hub_feature.config_feature.name
  membership = google_gke_hub_membership.membership-cluster-b.membership_id
  configmanagement {
    version = "1.6.2"
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
}*/