resource "google_project_service" "services" {
  for_each = toset([
    "gkehub.googleapis.com",
    "container.googleapis.com",
    "connectgateway.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "anthos.googleapis.com",
    "anthosconfigmanagement.googleapis.com",
    "multiclusteringress.googleapis.com",
    "multiclusterservicediscovery.googleapis.com"
  ])
  service = each.value
  disable_on_destroy = false
}

resource "google_gke_hub_fleet" "fleet" {
  display_name = "commit-conf-demo-fleet"

  depends_on = [google_project_service.services]
}

resource "google_container_cluster" "cluster_a" {
  name     = "cluster-a"
  location = "us-central1"

  # Enable Autopilot mode
  enable_autopilot = true

  # Set the number of nodes in the cluster
  initial_node_count = 1

  project = data.google_project.project.project_id
  fleet {
    project = data.google_project.project.project_id
  }
  deletion_protection = false
}

resource "google_container_cluster" "cluster_b" {
  name     = "cluster-b"
  location = "europe-west1"

  # Enable Autopilot mode
  enable_autopilot = true

  # Set the number of nodes in the cluster
  initial_node_count = 1

  project = data.google_project.project.project_id
  fleet {
    project = data.google_project.project.project_id
  }
  deletion_protection = false
}
