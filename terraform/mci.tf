locals {
  config_membership = substr(google_container_cluster.cluster_a.fleet[0].membership, 24, -1)
}
resource "google_gke_hub_feature" "feature" {
  name = "multiclusteringress"
  location = "global"
  spec {
    multiclusteringress {
      config_membership = local.config_membership
    }
  }

  depends_on = [google_project_service.services]
}
