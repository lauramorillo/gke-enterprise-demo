locals {
  cluster_a_fleet = google_container_cluster.cluster_a.fleet[0]
  cluster_b_fleet = google_container_cluster.cluster_b.fleet[0]
}

#
# Define scopes
#
resource "google_gke_hub_scope" "ad_exchange" {
  scope_id = "ad-exchange"
}

#
# Bind cluster and scopes
#

resource "google_gke_hub_membership_binding" "cluster_a_ad_exchange" {
  membership_binding_id = "${local.cluster_a_fleet.membership_id}-${google_gke_hub_scope.ad_exchange.scope_id}"
  scope = google_gke_hub_scope.ad_exchange.name
  membership_id = local.cluster_a_fleet.membership_id
  location = local.cluster_a_fleet.membership_location
}

resource "google_gke_hub_membership_binding" "cluster_b_ad_exchange" {
  membership_binding_id = "${local.cluster_b_fleet.membership_id}-${google_gke_hub_scope.ad_exchange.scope_id}"
  scope = google_gke_hub_scope.ad_exchange.name
  membership_id = local.cluster_b_fleet.membership_id
  location = local.cluster_b_fleet.membership_location
}

#
# Define namespaces
#

resource "google_gke_hub_namespace" "ad_exchange" {
  scope_namespace_id = "ad-exchange"
  scope_id = google_gke_hub_scope.ad_exchange.scope_id
  scope = google_gke_hub_scope.ad_exchange.id
}

#
# Grant scope access
#

resource "google_gke_hub_scope_rbac_role_binding" "ad_exchange" {
  scope_rbac_role_binding_id = "ad-exchange-binding"
  scope_id = google_gke_hub_scope.ad_exchange.scope_id
  group = "ad_exchange@seedtag.com"
  role {
    predefined_role = "EDIT"
  }
}
